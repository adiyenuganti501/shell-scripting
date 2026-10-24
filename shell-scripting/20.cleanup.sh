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
  usage()
fi

if [ ! -d "$source_dir" ] ; then
    echo "ERROR $source_dir does not exist"
fi



