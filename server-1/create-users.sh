#!/bin/bash
# This script can read the raw csv data from io and create the users according to it

while IFS=',' read -r name firstName lastName username email department employeeID; do
    #create user and dept. group
    useradd -m -s /bin/bash -c "$name" "$username"
    groupadd "$department"
    usermod -aG "$department" "$username"
    # set comment with email address
    usermod -c "$email" "$username"
    # he logs in with pwd 1234, then he must change pwds
    echo "$username:changeme123" | chpasswd
    passwd --expire "$username"
done
