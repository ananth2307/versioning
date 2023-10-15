#!/bin/bash

# Define your initial version (e.g., 0.1.0)
version="0.1.0"

# Get the latest Git tag
latest_tag=$(git describe --tags --abbrev=0 2>/dev/null || echo "")

# If there's a latest tag, parse it to determine the major, minor, and patch version
if [[ -n $latest_tag ]]; then
    major_minor_patch=($(echo $latest_tag | sed 's/v//; s/\./ /g'))
    major=${major_minor_patch[0]}
    minor=${major_minor_patch[1]}
    patch=${major_minor_patch[2]}

    # Increment the appropriate version based on commit messages
    while IFS= read -r commit; do
        case $commit in
            *BREAKING*) major=$((major + 1)) minor=0 patch=0 ;;
            *FEATURE*)  minor=$((minor + 1)) patch=0 ;;
            *FIX*)      patch=$((patch + 1)) ;;
            *) continue ;;
        esac
    done < <(git log --pretty=format:"%s")

    # Set the new version
    version="${major}.${minor}.${patch}"
fi

# Output the version
echo "$version"
