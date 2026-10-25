# Creating a Custom Linux Command Using a Shell Script and AWS AMI

### 1. Objective

Create a custom Linux command using a shell script, store it in `/usr/local/bin`, and make it available on EC2 instances launched from a custom Amazon Machine Image (AMI).

### 2. Create the Shell Script

Create a script named `archive` in `/usr/local/bin`.

```bash
sudo vi /usr/local/bin/archive
```

Example script:

```bash
#!/bin/bash

SOURCE_DIR="$1"
DEST_DIR="$2"

if [ "$(id -u)" -ne 0 ]; then
    echo "Please run this command with sudo."
    exit 1
fi

if [ -z "$SOURCE_DIR" ] || [ -z "$DEST_DIR" ]; then
    echo "Usage: sudo archive <source_directory> <destination_directory>"
    exit 1
fi

mkdir -p "$DEST_DIR"

ARCHIVE_FILE="$DEST_DIR/archive-$(date +%Y%m%d-%H%M%S).tar.gz"

if tar -czf "$ARCHIVE_FILE" -C "$SOURCE_DIR" .; then
    echo "Archive created successfully: $ARCHIVE_FILE"
else
    echo "Archive creation failed."
    exit 1
fi
```

### 3. Make the Script Executable

```bash
sudo chmod +x /usr/local/bin/archive
```

The execute permission allows the script to run as a command.

### 4. Execute the Custom Command

Example:

```bash
sudo archive /var/log /tmp/log-archives
```

**Explanation:**

* `archive` — custom command created using the shell script.
* `/var/log` — source directory to archive.
* `/tmp/log-archives` — destination directory where the archive is stored.
* `sudo` — runs the command with root privileges.

Because `/usr/local/bin` is normally included in the Linux `PATH`, the command can be executed without specifying the complete script path.

### 5. Create a Custom AMI

After testing the script:

1. Open the AWS Management Console.
2. Navigate to **EC2 → Instances**.
3. Select the EC2 instance containing the script.
4. Choose **Actions → Image and templates → Create image**.
5. Enter an AMI name, such as `custom-linux-archive-ami`.
6. Create the image and wait until its status becomes available.

The AMI captures the instance's operating system, installed software, and script.

### 6. Launch a New EC2 Instance

1. Navigate to **EC2 → AMIs**.
2. Select your custom AMI.
3. Launch a new EC2 instance using that AMI.
4. Connect to the new instance.
5. Run the command:

```bash
sudo archive /var/log /tmp/log-archives
```

The command should work without recreating the script, provided its permissions and dependencies are intact.

### 7. Share the AMI With Other Users

There are three common AMI access options:

* **Private AMI:** Available to the owning AWS account and authorized principals.
* **Shared AMI:** Shared with specific AWS accounts.
* **Public AMI:** Made available for other AWS users to discover and launch, subject to AWS requirements.

Users must have their own AWS credentials and appropriate permissions to launch EC2 instances.

### 8. Advantages

* Reuses scripts across multiple EC2 instances.
* Avoids manually creating the same command on every server.
* Standardizes system administration tasks.
* Reduces setup time and configuration errors.
* Helps maintain a consistent environment across instances.

### 9. DevOps Interview Answer

"I created a custom Linux archival command using a Bash script and stored it in `/usr/local/bin` so that it could be executed directly from the terminal. After testing the script, I created a custom Amazon Machine Image (AMI) from the EC2 instance. Other instances launched from that AMI can use the same archival command without manually creating or configuring the script again."

### Key Takeaway

**Bash script + executable permissions + `/usr/local/bin` + custom AMI = a reusable Linux command available on EC2 instances launched from that AMI.**
