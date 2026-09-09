#!/bin/bash

set -u

USERNAME="student_test"
PASSWORD="Student@123"
SCRIPT="./starter.sh"

PASS=0
FAIL=0

pass_test() {
    echo "PASS: $1"
    PASS=$((PASS + 1))
}

fail_test() {
    echo "FAIL: $1"
    FAIL=$((FAIL + 1))
}

echo "=========================================="
echo "Linux User Management Autograder"
echo "=========================================="

# ------------------------------------------
# Test 1: starter.sh exists
# ------------------------------------------

if [ -f "$SCRIPT" ]; then
    pass_test "starter.sh exists"
else
    fail_test "starter.sh does not exist"
    exit 1
fi

# ------------------------------------------
# Test 2: Bash syntax
# ------------------------------------------

if bash -n "$SCRIPT"; then
    pass_test "starter.sh has valid Bash syntax"
else
    fail_test "starter.sh contains Bash syntax errors"
fi

# ------------------------------------------
# Test 3: useradd command
# ------------------------------------------

if grep -Eq '(^|[[:space:];])useradd([[:space:];]|$)' "$SCRIPT"; then
    pass_test "Script contains useradd command"
else
    fail_test "Script does not contain useradd command"
fi

# ------------------------------------------
# Test 4: password command
# ------------------------------------------

if grep -Eq '(^|[[:space:];])(passwd|chpasswd)([[:space:];]|$)' "$SCRIPT"; then
    pass_test "Script contains password-setting command"
else
    fail_test "Script does not contain passwd or chpasswd command"
fi

# ------------------------------------------
# Test 5: userdel command
# ------------------------------------------

if grep -Eq '(^|[[:space:];])userdel([[:space:];]|$)' "$SCRIPT"; then
    pass_test "Script contains userdel command"
else
    fail_test "Script does not contain userdel command"
fi

# ------------------------------------------
# Clean up before execution
# ------------------------------------------

if id "$USERNAME" >/dev/null 2>&1; then
    sudo userdel -r "$USERNAME" >/dev/null 2>&1 || true
fi

# ------------------------------------------
# Test 6: Execute student script
# ------------------------------------------

echo ""
echo "Running student script..."

if timeout 30 sudo bash "$SCRIPT"; then
    pass_test "starter.sh executed successfully"
else
    fail_test "starter.sh failed during execution"
fi

# ------------------------------------------
# Test 7: Verify user was deleted
# ------------------------------------------

if id "$USERNAME" >/dev/null 2>&1; then
    fail_test "User '$USERNAME' still exists after script execution"
else
    pass_test "User '$USERNAME' was deleted"
fi

# ------------------------------------------
# Final cleanup
# ------------------------------------------

if id "$USERNAME" >/dev/null 2>&1; then
    sudo userdel -r "$USERNAME" >/dev/null 2>&1 || true
fi

# ------------------------------------------
# Summary
# ------------------------------------------

echo ""
echo "=========================================="
echo "Test Summary"
echo "=========================================="
echo "Passed: $PASS"
echo "Failed: $FAIL"
echo "=========================================="

if [ "$FAIL" -eq 0 ]; then
    echo "ALL TESTS PASSED"
    exit 0
else
    echo "SOME TESTS FAILED"
    exit 1
fi
