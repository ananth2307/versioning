#!/bin/bash

# Define your initial version
version=$(grep -Eo '"version": ".*",' package.json | sed 's/"version": "\(.*\)",/\1/')

# Check the latest commit message for specific keywords
latest_commit_msg=$(git log --format=%B -n 1 HEAD)

if [[ $latest_commit_msg == *BREAKING* ]]; then
    version=$(npm version major)
elif [[ $latest_commit_msg == *FIX* ]]; then
    version=$(npm version patch)
fi

# Output the updated version
echo "$version"
