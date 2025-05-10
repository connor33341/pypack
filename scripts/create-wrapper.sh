#!/bin/bash

# URL of the shell script to download
SCRIPT_URL="https://github.com/connor33341/pypack/raw/refs/heads/main/scripts/wrappers/linux.sh"

# Name of the downloaded file
SCRIPT_NAME="pypack.sh"

# Download the shell script
curl -o "$SCRIPT_NAME" "$SCRIPT_URL"

# Make the downloaded script executable
chmod +x "$SCRIPT_NAME"

# Execute the downloaded script
./"$SCRIPT_NAME"