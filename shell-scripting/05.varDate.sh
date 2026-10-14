#!/bin/bash
START_TIME= $(date +%s)
echo "Script execution started at: $(date)"

sleep 5

END_TIME= $(date +%s)
echo "Script execution ended at: $(date)"

EXECUTION_TIME=$((END_TIME - START_TIME))
echo "Total execution time: $EXECUTION_TIME seconds"