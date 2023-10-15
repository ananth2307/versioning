#!/bin/bash

# Get the version from package.json using native shell tools
version=$(./versioning.sh)

# Build the Docker image and tag it with the version from package.json
docker build -t helloworld-node:$version .
