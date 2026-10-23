#!/bin/bash

START_TIME=$(date +%s)
echo "Script execution started at: $START_TIME"

sleep 5

END_TIME=$(date +%s)
echo "Script execution ended at: $END_TIME"

EXECUTION_TIME=$((END_TIME - START_TIME))
echo "Total execution time: $EXECUTION_TIME seconds"