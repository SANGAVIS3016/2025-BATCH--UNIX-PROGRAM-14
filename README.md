# Linux User Management – Add, Set Password, and Delete User

## Aim

To create a Linux user, set the user's password, and delete the user using Linux commands.

## Learning Objectives

After completing this assignment, students should be able to:

1. Create a Linux user using `useradd`.
2. Set a user's password using `passwd`.
3. Delete a Linux user using `userdel`.
4. Write and execute a Bash shell script.
5. Understand basic Linux user-management commands.

---

## Problem Statement

Write a Bash script that performs the following operations:

1. Create a Linux user.
2. Set a password for the user.
3. Delete the user.

The script should use the following Linux commands:

* `useradd`
* `passwd`
* `userdel`

---

## Algorithm

### Step 1

Open Terminal on your Linux machine.

### Step 2

Create a user using the `useradd` command.

### Step 3

Set the password of the user using the `passwd` command.

### Step 4

Delete the user using the `userdel` command.

### Step 5

Close the Terminal.

---

## Student Task

Complete the file:

```text
starter.sh
```

Your script must:

1. Create a user named:

```text
student_test
```

2. Set the password:

```text
Student@123
```

3. Delete the user after setting the password.

---

## Expected Commands

Students are expected to learn and use commands equivalent to:

```bash
useradd student_test
```

```bash
passwd
```

and

```bash
userdel student_test
```

The exact implementation may vary as long as the required functionality is achieved.

---

## Important

Do **not** modify the GitHub Actions workflow or test files.

Only modify:

```text
starter.sh
```

Do not hard-code the test results or attempt to bypass the tests.

---

## How to Run Locally

Make the script executable:

```bash
chmod +x starter.sh
```

Run it with administrator privileges:

```bash
sudo ./starter.sh
```

After execution, verify that the user has been deleted:

```bash
id student_test
```

The command should report that the user does not exist.

---

## Submission

Commit and push your completed `starter.sh` file to GitHub.

Example:

```bash
git add starter.sh
git commit -m "Complete Linux user management assignment"
git push
```

GitHub Actions will automatically execute the tests.

---

## Expected Result

The script should successfully:

* Create `student_test`
* Set its password to `Student@123`
* Delete `student_test`

At the end of execution, the user should no longer exist.

---

## Grading

| Criteria                        |  Marks |
| ------------------------------- | -----: |
| Correctly creates the user      |      3 |
| Correctly sets the password     |      3 |
| Correctly deletes the user      |      3 |
| Script execution/error handling |      1 |
| **Total**                       | **10** |

---

## Restrictions

* Do not manually create the required user outside the script.
* Do not manually delete the user outside the script.
* Do not modify the test files.
* Do not modify the GitHub Actions workflow.
* Do not bypass the automated tests.

---

## Repository Structure

Your repository will contain:

```text
.
├── README.md
├── starter.sh
├── test.sh
└── .github
    └── workflows
        └── autograding.yml
```

Only `starter.sh` should normally be modified by the student.


