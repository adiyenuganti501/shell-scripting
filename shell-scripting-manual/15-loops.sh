#!/bin/bash
user_id=$(id -u)
logs_folder="/var/logs/shell_logs"
logs_file="$logs_folder/${0}.log"

if [ $user_id -ne 0 ] ; then 
    echo "You are not a root user. Please run the script as root user."
    exit 1
fi

mkdir -p "$logs_folder"

echo "Script execution starts at $(date +"%F %T")" | tee -a $logs_file

validation(){

    if [ $1 -ne 0 ]; then
      echo "$2 Installation Failed. Please check the error and try again." | tee -a $logs_file
      exit 1
    else
       echo "$2 Installation completed successfully."  | tee -a $logs_file
    fi
}

dnf install -y mysql | &>> $logs_file
validation $? "mysql"

dnf install -y mysql-server | &>> $logs_file
validation $? "mysql-server"



echo "Script execution ends at $(date +"%F %T")" |  tee -a $logs_file
