#!/bin/bash
user_id=$(id -u)
source_dir=$1
dest_dir=$2
days=${3:-14}  #default value 14 if user did not provide days

if [ "$user_id" -ne 0 ] ; then
   echo "Please ececute with Sudo user"
   exit 1
fi
usage(){
    echo "Usage :: $0 [SOURCE_DIR] [DESTIATION_DIR] [DAYS(optional, default 14 days)]"
    exit 1
}
if [ -z "$source_dir" ] || [ -z "$dest_dir" ]; then
   echo "ERROR missing directories"
   usage
fi

if [ ! -d "$source_dir" ]; then
   echo "Source directory :$source_dir is missing"
   exit 1
fi

if [ ! -d "$dest_dir" ]; then
   echo "Destination directory :$dest_dir is missing"
   exit 1
fi