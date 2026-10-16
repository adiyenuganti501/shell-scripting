#!/bin/bash
user_id=$(id -u)  #Prints the user id of the current user
logs_folder="/var/logs/shell_logs"  #Path to the logs folder
logs_file="$logs_folder/${0}.log"  #${0} is the name of the script file

if [ $user_id -ne 0 ] ; then
    echo "You are not a root user. Please run the script as root user."
    exit 1
fi

mkdir -p "$logs_folder"  #Creates the logs folder if it does not exist
echo "Script execution starts at $(date +"%F %T")" | tee -a $logs_file  #Prints the start time of the script execution in the logs file

validation(){
    if [ $1 -ne 0 ] ; then
        echo "$2 Installation Failed. Please check the error and try again." | tee -a $logs_file
        exit 1
    else
        echo "$2 Installation completed successfully."  | tee -a $logs_file
    fi
}