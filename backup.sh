#!/bin/bash

# Check if the correct number of arguments are passed
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <source directory> <destination directory>"
    exit 1
fi

# Assign arguments to variables for better readability
source_dir=$1
dest_dir=$2

# Get current date and time for the timestamp
timestamp=$(date +%Y-%m-%d_%H-%M-%S)

# Create the backup filename
backup_name=$(basename "$source_dir")_$timestamp.tar.gz

# Create the backup archive
tar -czf "$dest_dir/$backup_name" "$source_dir"

# Check if the backup was successful
if [ $? -eq 0 ]; then
    echo "Backup of $source_dir was successful!"
    echo "Backup file is located at $dest_dir/$backup_name"
else
    echo "Backup failed!"
fi
