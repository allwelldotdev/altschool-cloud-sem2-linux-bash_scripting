#!/bin/bash

# Initialize variables for flags
showDetails=false
numEntries=8 # default value

# Process command-line options using a while loop and a case statement
while getopts "dn:" opt; do
  case $opt in
    d) showDetails=true ;; # Set showDetails to true if -d is provided
    n) numEntries=$OPTARG ;; # Set numEntries to the provided value if -n is provided
    \?) echo "Invalid option: -$OPTARG" >&2; exit 1 ;; # Handle invalid options
  esac
done

# Shift off the options and flags processed by getopts
shift $((OPTIND -1))

# Check if at least one directory is provided
if [ $# -eq 0 ]; then
  echo "Usage: $0 [-d] [-n NUM_ENTRIES] directory [directory ...]"
  exit 1
fi

# Loop through all directories provided as arguments
for dir in "$@"; do
  if [ -d "$dir" ]; then # Check if the directory exists
    echo "Analyzing disk usage for: $dir"
    if [ "$showDetails" = true ]; then
      # Show detailed disk usage including files, sort by size, and limit to top N entries
      du -ah "$dir" | sort -rh | head -n $numEntries
    else
      # Show summary disk usage for directories only, sort by size, and limit to top N entries
      du -sh "$dir"/* | sort -rh | head -n $numEntries
    fi
  else
    echo "Directory not found: $dir" >&2 # Error message for non-existent directory
  fi
done
