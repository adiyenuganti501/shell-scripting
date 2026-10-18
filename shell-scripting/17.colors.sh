#!/bin/bash
user_id=$(id -u)  #Prints the user id of the current user

logs_folder="/var/logs/shell_logs"  #Path to the logs folder
logs_file="$logs_folder/${0}.log"
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

if [ $user_id -ne 0 ] ; then
   echo -e "${R}You are not a root user. Please run the script as root user.${N}"
   exit 1
fi

if [ $# -eq 0 ] ; then
   echo -e "${Y}Usage: $0 <package1> <package2> ...${N}"
   exit 1
fi

mkdir -p "$logs_folder"  #Creates the logs folder if it does not exist
echo -e "${G}Script execution starts at $(date +"%F %T")${N}" | tee -a $logs_file  #Prints the start time of the script execution in the logs file

validation(){
    if [ $1 -ne 0 ] ; then
        echo -e "${R}$2 Installation Failed. Please check the error and try again.${N}" | tee -a $logs_file
        exit 1
    else
        echo -e "${G}$2 Installation completed successfully.${N}"  | tee -a $logs_file
    fi
}

for package in "$@"; do
    if rpm -q "$package" &>/dev/null; then
        echo -e "${G}$package is already installed.${N}" | tee -a $logs_file
    else
        echo -e "${Y}$package is not installed. Installing...${N}" | tee -a $logs_file
        dnf install -y "$package" &>> $logs_file
        validation $? "$package"
    fi
done

echo -e "${G}Script execution ends at $(date +"%F %T")${N}" | tee -a $logs_file  #Prints the end time of the script execution in the logs file