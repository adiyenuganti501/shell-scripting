#!/bin/bash
user_id=$(id -u)  #Prints the user id of the current user

if [ $user_id -ne 0 ] ; then
    echo "You are not a root user. Please run the script as root user."
    exit 1
fi


