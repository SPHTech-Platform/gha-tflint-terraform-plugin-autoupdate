#!/bin/bash

# Define the GitHub repository owner and name
owner="terraform-linters"
repo="tflint-ruleset-terraform"

# Use curl to make a GET request to the GitHub API to get the latest release information
response=$(curl -s "https://api.github.com/repos/$owner/$repo/releases/latest")

# Check if the request was successful
if [ $? -ne 0 ]; then
  echo "Failed to fetch release information."
  exit 1
fi

# Parse the JSON response to extract the latest release version
latest_version=$(echo "$response" | grep -oP '"tag_name": "\K([^"]+)')

if [ -z "$latest_version" ]; then
  echo "Failed to extract latest version."
  exit 1
fi

echo "Latest version of $repo is $latest_version"
strip_version=$(echo "$latest_version" | sed 's/v//g')

hcl_file="./.tflint.hcl"

# Use awk to update the version value in the .hcl file within the plugin block
awk -i inplace '
    /plugin "terraform" \{/,/\}/ {
    if ($0 ~ /version = ".+"/) {
        sub(/version = ".+"/, "version = \""new_version"\"")
    }
    }
    { print }
' new_version="$strip_version" "$hcl_file"
echo "Updated version in $hcl_file to $strip_version"
