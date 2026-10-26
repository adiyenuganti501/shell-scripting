#!/bin/bash

disk_ussage=$(df -hT | grep -v Filesystem)
echo "The Disk Ussage is : $disk_ussage"