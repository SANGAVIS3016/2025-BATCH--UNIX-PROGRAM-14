#!/bin/bash

# Define the test user
USERNAME="student_test"

# 1. Add user using useradd
useradd "$USERNAME"

# 2. Set user password using chpasswd (or passwd)
echo "$USERNAME:Password123!" | chpasswd

# 3. Delete user using userdel
userdel -r "$USERNAME"

echo "User management operations completed."
