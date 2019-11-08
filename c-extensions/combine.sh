#!/bin/bash

# Check script is being run from the root of the repo
if [[ $(git rev-parse --show-toplevel) != "$PWD" ]]; then
    echo "Please run from the root of the repo"
    exit 1
fi

echo "List combiner for seclists-c"

# Declare settings
dns_excluded=("/subdomains-top1million-20000.txt")
declare -A dns=(
        ["wd"]="Discovery/DNS"
        ["out"]="dns-full.txt"
        ["excluded"]=dns_excluded
    )

# Create list of lists
lists=(dns)

total="${#lists[@]}"
echo "$total lists to create"

# Create each list
index=0
for list_name in "${lists[@]}"; do
    index=$((index+1))
    declare -n list="$list_name"

    # Find text files in given directory
    sublists=("${list[wd]}"/*.txt)

    echo "${sublists[@]}"

    # Remove excluded files from sublists
    declare -n excluded="${list[excluded]}"
    for i in "${!sublists[@]}"; do
        for excl in "${excluded[@]}"; do
            if [[ "${sublists[i]}" == *"$excl" ]]; then
                unset 'sublists[i]'
            fi
        done
    done

    # Print sublist info
    sublist_count="${#sublists[@]}"
    echo "$index/$total Combining $sublist_count lists into ${list[out]}"
done
