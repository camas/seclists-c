#!/bin/bash

# Allow recursive globs
shopt -s globstar

# Check script is being run from the root of the repo
if [[ $(git rev-parse --show-toplevel) != "$PWD" ]]; then
    echo "Please run from the root of the repo"
    exit 1
fi

echo "List combiner for seclists-c"

# Declare list settings
dns_excluded=("subdomains-top1million-20000.txt" "subdomains-top1million-5000.txt" 
    "bitquark-subdomains-top100000.txt" "deepmagic.com-prefixes-top500.txt")
declare -A dns=(
    ["wd"]="Discovery/DNS"
    ["out"]="dns-full.txt"
    ["excluded"]=dns_excluded
)
webcontent_excluded=("Domino-Hunter/Commands-Views.txt" "Domino-Hunter/Commands-NSF.txt"
    "Domino-Hunter/Commands-Documents.txt" "SVNDigger/ReadMe.txt" 
    "default-web-root-directory-linux.txt" "default-web-root-directory-windows.txt"
    "JavaScript-Miners.txt" "local-ports.txt" "Public-Source-Repo-Issues.txt"
    "raft-large-extensions.txt" "raft-large-extensions-lowercase.txt"
    "raft-medium-extensions.txt" "raft-medium-extensions-lowercase.txt"
    "raft-small-extensions.txt" "raft-small-extensions-lowercase.txt"
    "web-extensions.txt" "web-mutations.txt")
declare -A webcontent=(
    ["wd"]="Discovery/Web-Content"
    ["out"]="webcontent-full.txt"
    ["excluded"]=webcontent_excluded
)
xss_excluded=("XSS-With-Context-Jhaddix.txt" "XSS-Vectors-Mario.txt")
declare -A xss=(
    ["wd"]="Fuzzing/XSS"
    ["out"]="xss-full.txt"
    ["excluded"]=xss_excluded
)
useragent_excluded=()
declare -A useragent=(
    ["wd"]="Fuzzing/User-Agents"
    ["out"]="useragent-full.txt"
    ["excluded"]=useragent_excluded
)
lfi_excluded=()
declare -A lfi=(
    ["wd"]="Fuzzing/LFI"
    ["out"]="lfi-full.txt"
    ["excluded"]=lfi_excluded
)
passwords_excluded=("Default-Credentials/db2-betterdefaultpasslist.txt"
    "Default-Credentials/ftp-betterdefaultpasslist.txt"
    "Default-Credentials/mssql-betterdefaultpasslist.txt"
    "Default-Credentials/mysql-betterdefaultpasslist.txt"
    "Default-Credentials/Oracle EBS userlist.txt"
    "Default-Credentials/oracle-betterdefaultpasslist.txt"
    "Default-Credentials/postgres-betterdefaultpasslist.txt"
    "Default-Credentials/ssh-betterdefaultpasslist.txt"
    "Default-Credentials/telnet-betterdefaultpasslist.txt"
    "Default-Credentials/telnet-phenoelit.txt"
    "Default-Credentials/tomcat-betterdefaultpasslist.txt"
    "Default-Credentials/windows-betterdefaultpasslist.txt"
    "Leaked-Databases/bible-withcount.txt"
    "Leaked-Databases/elitehacker-withcount.txt"
    "Leaked-Databases/faithwriters-withcount.txt"
    "Leaked-Databases/hak5-withcount.txt"
    "Leaked-Databases/honeynet-withcount.txt"
    "Leaked-Databases/muslimMatch-withcount.txt"
    "Leaked-Databases/myspace-withcount.txt"
    "Leaked-Databases/phpbb-withcount.txt"
    "Leaked-Databases/porn-unknown-withcount.txt"
    "Leaked-Databases/rockyou-withcount.txt"
    "Leaked-Databases/singles.org-withcount.txt"
    "Malware/mirai-botnet.txt")
declare -A passwords=(
    ["wd"]="Passwords"
    ["out"]="passwords-full.txt"
    ["excluded"]=passwords_excluded
)
names_excluded=()
declare -A names=(
    ["wd"]="Usernames"
    ["out"]="usernames-full.txt"
    ["excluded"]=names_excluded
)

# Create list of lists
lists=(dns webcontent xss useragent lfi passwords names)

total="${#lists[@]}"
echo "$total lists to create"

# Create each list
index=0
for list_name in "${lists[@]}"; do
    index=$((index+1))
    declare -n list="$list_name"

    # Find text files in given directory recursively
    sublists=("${list[wd]}"/**/*.txt)

    # Remove excluded files from sublists
    declare -n excluded="${list[excluded]}"
    for i in "${!sublists[@]}"; do
        for excl in "${excluded[@]}"; do
            if [[ "${sublists[i]}" == */"$excl" ]]; then
                unset 'sublists[i]'
            fi
        done
    done

    # Remove output file from sublists (might have already been created)
    for i in "${!sublists[@]}"; do
        if [[ "${sublists[i]}" == */"${list[out]}" ]]; then
            unset 'sublists[i]'
        fi
    done

    # Print sublist info
    sublist_count="${#sublists[@]}"
    out_path="${list[wd]}/${list[out]}"
    echo "$index/$total Combining $sublist_count lists from ${list[wd]} into $out_path"
    # explicitly create 8 parallel threads despite it being default for most machines
    # -SG1 to make sure sort doesnt treat piped input as small file
    # LC_ALL=C speeds up sort by sorting by byte value
    cat "${sublists[@]}" | LC_ALL=C sort --parallel=8 -S1G -u -o "$out_path"
done
