#!/bin/bash

# Allow recursive globs
shopt -s globstar

# Find all text files
text_files=(**/*.txt)
echo "Checking ${#text_files[@]} files"

# Check each one
for file in "${text_files[@]}"; do
    size=$(wc -c < "$file")
    if ((size >= 104857600)); then
        echo "$file is larger than 100Mb"
    fi
done
