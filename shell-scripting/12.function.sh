#!/bin/bash
user_id=$(id -u)
echo "User ID: $user_id"
if [ $user_id -ne 0 ]; then
  echo "You are not a root user. Please run the script as root user."
  exit 1
fi
