#!/bin/bash
user_id= $(id -u)  #Prints the user id of the current user

log_folder="/var/logs/shell_logs"
log_file="$log_folder/${0}.log"  #${0} is the name of the script file

if [ $user_id -ne 0 ] ; then
    echo "You are not a root user. Please run the script as root user."
    exit 1
fi

mkdir -p $log_folder  #Creates the logs folder if it does not exist
echo "Script execution starts at $(date +"%F %T")" | tee -a $log_file  #Prints the start time of the script execution in the logs file

validation(){
    if [ $1 -ne 0 ] ; then
        echo "$2 Installation Failed. Please check the error and try again" | tee -a $log_file
        exit 1
    else
        echo "$2 Installation completed successfully."  | tee -a $log_file
    fi
}

for package in $@
do
    dnf list installed $package &>> $log_file
     if [ $? -ne 0 ] ; then
        echo "$package will be installed." | tee -a $log_file
        dnf install -y $package &>> $log_file
        validation $? "$package"
    else
        echo "$package is already installed."  | tee -a $log_file
    fi
done