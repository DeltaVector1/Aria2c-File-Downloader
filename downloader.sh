#!/bin/bash

# Enable debugging for troubleshooting (can be disabled later)
set -x

# Directory to save the downloaded files
SAVE_DIR="downloads"

# Create the directory if it doesn't exist
mkdir -p "$SAVE_DIR"

# File containing the list of URLs
URL_FILE="urls.txt"

# Check if the URL file exists
if [[ ! -f "$URL_FILE" ]]; then
    echo "Error: $URL_FILE does not exist."
    exit 1
fi

# Check if aria2c is installed
if ! command -v aria2c >/dev/null 2>&1; then
    echo "Error: aria2c is not installed. Please install it and try again."
    exit 1
fi

# Convert URLs file to Unix-style line endings to avoid issues
if command -v dos2unix >/dev/null 2>&1; then
    dos2unix "$URL_FILE"
else
    sed -i 's/\r$//' "$URL_FILE"
fi

# Read each URL from the file
while IFS= read -r url; do
    # Debugging output for the URL being processed
    echo "Processing URL: '$url'"

    # Check if the URL is empty or consists only of whitespace
    if [[ -z "$url" || "$url" =~ ^[[:space:]]*$ ]]; then
        echo "Skipping empty or whitespace-only line."
        continue
    fi

    # Extract the filename from the URL, stripping query parameters
    filename=$(basename "${url%%\?*}")

    # Fallback for a filename in case basename fails
    if [[ -z "$filename" ]]; then
        filename="unknown_file_$(date +%s)"
    fi

    echo "Downloading $url to $SAVE_DIR/$filename"

    # Download the file using aria2c and save it to the specified directory
    aria2c -x 16 -d "$SAVE_DIR" -o "$filename" "$url"

    # Check if the download was successful
    if [[ $? -eq 0 ]]; then
        echo "Download of $filename successful."
    else
        echo "Download of $filename failed."
    fi
done < "$URL_FILE"

# Disable debugging after script completion
set +x

echo "Script execution completed."
