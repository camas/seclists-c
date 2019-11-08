#!/bin/bash

# Allow recursive globs
shopt -s globstar

# Check script is being run from the root of the repo
if [[ $(git rev-parse --show-toplevel) != "$PWD" ]]; then
    echo "Please run from the root of the repo"
    exit 1
fi

text_files=(**/*.txt)
echo "Checking ${#text_files[@]} files" 

for file in "${text_files[@]}"; do
    blank=$(tail -c1 "$file")
    if [[ "$blank" != $'' ]]; then
        echo "$file has non-blank last line"
        echo "    $(tail -c16 "$file" | xxd)"
    fi
done
