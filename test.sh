#!/bin/bash

# Initialize variables
version=""
size=""

# Read through the YAML file line by line
while IFS=: read -r key value; do
  # Trim leading and trailing whitespace from key and value
  key=$(echo "$key" | xargs)
  value=$(echo "$value" | xargs)

  # Capture the version
  if [[ "$key" == "version" ]]; then
    version=$(echo "$value" | tr -d '"')
  fi

  # Capture the size for the specific version
  if [[ "$key" == "\"$version\"" ]]; then
    size=$(echo "$value" | tr -d '"')
  fi
done < params.yml

# Display the results
echo "Version is $version with size $size"

