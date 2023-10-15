#!/bin/bash

# Get the version from package.json using native shell tools
version=$(grep -Eo '"version": ".*",' package.json | sed 's/"version": "\(.*\)",/\1/')

# Build the Docker image and tag it with the version from package.json
docker build -t helloworld-node:$version .

