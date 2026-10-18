```bash
#!/bin/bash

# Get the current user ID
user_id=$(id -u)

# Define log directory and file
log_folder="/var/log/shell_logs"
script_name=$(basename "$0")
log_file="$log_folder/${script_name}.log"

# Check whether the user is root
if [ "$user_id" -ne 0 ]; then
    echo "You are not a root user. Please run the script as root."
    exit 1
fi

# Check whether package arguments are provided
if [ "$#" -eq 0 ]; then
    echo "Usage: $0 <package1> <package2> ..."
    exit 1
fi

# Create the log directory
mkdir -p "$log_folder"

# Log script start time
echo "Script execution started at $(date '+%F %T')" | tee -a "$log_file"

# Function to validate installation
validation() {
    if [ "$1" -ne 0 ]; then
        echo "$2 installation failed. Please check the log file." | tee -a "$log_file"
        exit 1
    else
        echo "$2 installation completed successfully." | tee -a "$log_file"
    fi
}

# Check and install packages
for package in "$@"; do

    if rpm -q "$package" &>/dev/null; then
        echo "$package is already installed." | tee -a "$log_file"

    else
        echo "$package is not installed. Installing..." | tee -a "$log_file"

        dnf install -y "$package" &>> "$log_file"

        validation "$?" "$package"
    fi

done

# Log script completion time
echo "Script execution completed at $(date '+%F %T')" | tee -a "$log_file"
```
