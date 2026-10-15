#!/bin/bash
user_id=$(id -u)

if [ $user_id -ne 0 ]; then
     echo "You are not a root user. Please run the script as root user."
     exit 1
fi
dnf install -y nginx

if [ $? -ne 0 ]; then
   echo "Nginx installation failed. Please check the error and try again."
else
   echo "Nginx installation completed successfully."
fi

dnf install mysql -y

if [$? -ne 0 ]; then
    echo "MySQL installation failed. Please check the error and try again."
else
    echo "MySQL installation completed successfully."
fi