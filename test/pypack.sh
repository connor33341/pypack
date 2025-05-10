#!/bin/bash

# URLs for default .pypack and .pypack-config files
PYPACK_URL="https://raw.githubusercontent.com/connor33341/pypack/refs/heads/main/default/.pypack"
CONFIG_URL="https://raw.githubusercontent.com/connor33341/pypack/refs/heads/main/default/.pypack-config"

# Check for .pypack file
if ! ls *.pypack >/dev/null 2>&1; then
    echo "No .pypack file found. Downloading default from $PYPACK_URL"
    curl -o default.pypack "$PYPACK_URL"
    if [ $? -ne 0 ]; then
        echo "Failed to download default .pypack file"
        exit 1
    fi
fi

# Check for .pypack-config file
if ! ls *.pypack-config >/dev/null 2>&1; then
    echo "No .pypack-config file found. Downloading default from $CONFIG_URL"
    curl -o default.pypack-config "$CONFIG_URL"
    if [ $? -ne 0 ]; then
        echo "Failed to download default .pypack-config file"
        exit 1
    fi
fi

# Find the first .pypack-config file
CONFIG_FILE=$(ls *.pypack-config 2>/dev/null | head -n 1)
if [ -z "$CONFIG_FILE" ]; then
    echo "No .pypack-config file found after download attempt"
    exit 1
fi

# Read the executable URL from the .pypack-config file
EXE_URL=$(cat "$CONFIG_FILE")
if [ -z "$EXE_URL" ]; then
    echo ".pypack-config file is empty or invalid"
    exit 1
fi

# Download the executable
EXE_NAME="downloaded_exe"
echo "Downloading executable from $EXE_URL"
curl -o "$EXE_NAME" "$EXE_URL"
if [ $? -ne 0 ]; then
    echo "Failed to download executable"
    exit 1
fi

# Make the executable runnable
chmod +x "$EXE_NAME"

# Find the first .pypack file
PYPACK_FILE=$(ls *.pypack 2>/dev/null | head -n 1)
if [ -z "$PYPACK_FILE" ]; then
    echo "No .pypack file found after download attempt"
    exit 1
fi

echo "Found .pypack file: $PYPACK_FILE"
# Read arguments from the .pypack file
ARGS=$(cat "$PYPACK_FILE")
# Run the downloaded executable with the arguments
./"$EXE_NAME" $ARGS
if [ $? -ne 0 ]; then
    echo "Failed to run executable with arguments from $PYPACK_FILE"
    exit 1
fi