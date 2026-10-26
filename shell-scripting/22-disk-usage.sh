#!/bin/bash

disk_ussage=$(df -hT | grep -v Filesystem)
usage_threshold=20
server_ip=$(curl http://169.254.169.254/latest/meta-data/local-ipv4)

while IFS= read -r line  
do 
 usage=$(echo $line | awk '{print %6}' | cut -d "%d" -f1)
 
done
