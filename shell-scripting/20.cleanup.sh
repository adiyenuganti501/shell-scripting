#!/bin/bash
user_id=$(id -u)

if [ "$user_id" -ne 0 ] ; then
    echo "You are not a root user"
    exit 1
fi

source_dir=$1
days=${2:-14}   # if user is not passing the days we will take 14 days as default

usage(){
    echo"Usage :: $0 [SOURCE_DIR] [DAYS(optional, default 14 days)]"
    exit 1
}

if [ -z "$source_dir" ] ; then 
  echo "ERROR Missing parametores"
  usage
fi

if [ ! -d "$source_dir" ] ; then
    echo "ERROR $source_dir does not exist"
fi
echo "Scanning for the files which are older than $days in $source_dir"
files_to_delete=$(find $source_dir -type f -name "*.log" -mtime +$days)

if [ -z "$files_to_delete"] ; then 
  echo "No Logs files found  older than $days"
  exit 0
fi

while IFS= read -r line
do
 echo "these files will be deleted :$line"
done <<< "$files_to_delete"

# < --> file as input 
# <<< ---> Variable as input



