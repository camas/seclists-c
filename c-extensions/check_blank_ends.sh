#!/bin/bash

# Allow recursive globs
shopt -s globstar

# Find all text files
text_files=(**/*.txt)
echo "Checking ${#text_files[@]} files" 

# Check each one
for file in "${text_files[@]}"; do
    blank=$(tail -c1 "$file")
    if [[ "$blank" != $'' ]]; then
        # Print file name and last 16 chars
        echo "$file has non-blank last line"
        echo "    $(tail -c16 "$file" | xxd)"
    fi
done
