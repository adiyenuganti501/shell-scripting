#!/bin/bash

disk_ussage=$(df -hT | grep -v Filesystem)
