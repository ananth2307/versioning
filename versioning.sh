#!/bin/bash

# Get the latest commit message
latest_commit_msg=$(git log --format=%B -n 1 HEAD)

# Get the latest Docker image tag
latest_docker_tag=$(docker images --format "{{.Tag}}" helloworld-node | sort -V | tail -n 1)

# Check if latest_docker_tag is empty
if [ -z "$latest_docker_tag" ]; then
    # If it's empty, assign "1.0.0" as the initial value
    new_docker_tag="1.0.0"
else
    # If it's not empty, extract the version parts
    IFS='.' read -r -a version_parts <<<"$latest_docker_tag"

    if [[ $latest_commit_msg == *BREAKING* ]]; then
        ((version_parts[0]++))

    # Check for the presence of "FIX" in the latest commit message
    elif [[ $latest_commit_msg == *FIX* ]]; then
        # Increment the second part of the version
        ((version_parts[1]++))
    # Check for the presence of "FIX" in the latest commit message
    elif [[ $latest_commit_msg == *PATCH* ]]; then
        # Increment the second part of the version
        ((version_parts[2]++))
    fi

    # Construct the new Docker image tag using the updated version parts
    new_docker_tag="${version_parts[0]}.${version_parts[1]}.${version_parts[2]}"
fi

echo "$new_docker_tag"
