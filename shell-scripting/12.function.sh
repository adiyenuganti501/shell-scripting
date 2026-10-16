#!/bin/bash
user_id=$(id -u)
echo "User ID: $user_id"
if [ $user_id -ne 0 ]; then
  echo "You are not a root user. Please run the script as root user."
  exit 1
fi

validation() {
    if [$1 -ne 0 ] ; then
        echo "$2 Installation Failed. Please check the error and try again."
        exit 1
    else
        echo "$2 Installation completed successfully."
    fi
}

dnf install -y nginx
validation $? "Nginx"

dnf install mysql -y
validation $? "MySQL"

dnf install docker -y
validation $? "Docker"