#!/bin/bash

# ==========================================

# Linux User Management - Autograder

# ==========================================

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

# Test 1: Starter file exists

# ------------------------------------------

if [ -f "$SCRIPT" ]; then
pass_test "starter.sh exists"
else
fail_test "starter.sh does not exist"
exit 1
fi

# ------------------------------------------

# Test 2: Script is a valid Bash script

# ------------------------------------------

if bash -n "$SCRIPT"; then
pass_test "starter.sh has valid Bash syntax"
else
fail_test "starter.sh contains Bash syntax errors"
exit 1
fi

# ------------------------------------------

# Clean up before test

# ------------------------------------------

if id "$USERNAME" >/dev/null 2>&1; then
userdel "$USERNAME" >/dev/null 2>&1 || true
fi

# ------------------------------------------

# Test 3: Execute student script

# ------------------------------------------

echo ""
echo "Running student script..."

if timeout 30 sudo bash "$SCRIPT"; then
pass_test "starter.sh executed successfully"
else
fail_test "starter.sh failed during execution"
fi

# ------------------------------------------

# Test 4: User should be deleted

# ------------------------------------------

if id "$USERNAME" >/dev/null 2>&1; then
fail_test "User '$USERNAME' still exists after script execution"
else
pass_test "User '$USERNAME' was deleted"
fi

# ------------------------------------------

# Test 5: Check user creation/password

#

# Because the assignment deletes the user, the

# final state cannot directly prove the password.

#

# We therefore inspect the submitted script for

# password-setting functionality.

# ------------------------------------------

if grep -Eq 'passwd|chpasswd' "$SCRIPT"; then
pass_test "Script contains password-setting command"
else
fail_test "Script does not contain passwd or chpasswd"
fi

# ------------------------------------------

# Test 6: Check user creation command

# ------------------------------------------

if grep -Eq '\buseradd\b' "$SCRIPT"; then
pass_test "Script contains useradd command"
else
fail_test "Script does not contain useradd command"
fi

# ------------------------------------------

# Test 7: Check user deletion command

# ------------------------------------------

if grep -Eq '\buserdel\b' "$SCRIPT"; then
pass_test "Script contains userdel command"
else
fail_test "Script does not contain userdel command"
fi

# ------------------------------------------

# Final cleanup

# ------------------------------------------

if id "$USERNAME" >/dev/null 2>&1; then
userdel "$USERNAME" >/dev/null 2>&1 || true
fi

# ------------------------------------------

# Result

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
