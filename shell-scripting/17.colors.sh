#!/bin/bash

user_id=$(id -u)

logs_folder="/var/logs/shell_logs"
logs_file="$logs_folder/$(basename "$0").log"

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

if [ "$user_id" -ne 0 ]; then
    echo -e "${R}Please run this script as root.${N}"
    exit 1
fi

if [ "$#" -eq 0 ]; then
    echo -e "${Y}Usage: $0 <package1> <package2> ...${N}"
    exit 1
fi

mkdir -p "$logs_folder" || exit 1

echo -e "${G}Script execution starts at $(date '+%F %T')${N}" | tee -a "$logs_file"

for package in "$@"; do

    if rpm -q "$package" &>/dev/null; then
        echo -e "${G}$package is already installed.${N}" | tee -a "$logs_file"
    else
        echo -e "${Y}$package is not installed. Installing...${N}" | tee -a "$logs_file"

        if dnf install -y "$package" >> "$logs_file" 2>&1; then

            if rpm -q "$package" &>/dev/null; then
                echo -e "${G}$package installation completed successfully.${N}" | tee -a "$logs_file"
            else
                echo -e "${R}$package installation could not be verified.${N}" | tee -a "$logs_file"
                exit 1
            fi

        else
            echo -e "${R}$package installation failed. Check $logs_file${N}" | tee -a "$logs_file"
            exit 1
        fi
    fi

done

echo -e "${G}Script execution ends at $(date '+%F %T')${N}" | tee -a "$logs_file"

