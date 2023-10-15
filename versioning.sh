#!/bin/bash

# Get the latest commit message
latest_commit_msg=$(git log --format=%B -n 1 HEAD)

# Initialize the version
version="0.1.0"

# Check for specific keywords in the latest commit message
if [[ $latest_commit_msg == *BREAKING* ]]; then
    version=$(awk -F. '{print $1 + 1 ".0.0"}' <<< $version)
elif [[ $latest_commit_msg == *FIX* ]]; then
    version=$(awk -F. '{print $1 "." $2 + 1 ".0"}' <<< $version)
else
    version=$(awk -F. '{print $1 "." $2 "." $3 + 1}' <<< $version)
fi

# Get the latest Docker image tag
latest_docker_tag=$(docker images --format "{{.Tag}}" helloworld-node | sort -V | tail -n 1)

# Increment the tag version based on the commit message
new_docker_tag="${latest_docker_tag%%.*}.$version"

echo "$new_docker_tag"
