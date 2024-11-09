#!/bin/bash

# Read the version from params.yml using yq
version=$(yq eval '.version' params.yml)
size=$(yq eval ".size.\"$version\"" params.yml)

echo "Fetching data for version $version with size $size..."

# Download data using curl
curl -s "https://jsonplaceholder.typicode.com/photos?size=$size" -o temp_data.json

# Format and save data using jq (assuming 3 rows preview)
jq '. | .[0:3]' temp_data.json > datahub/data.json

# Check for changes in data
if cmp -s datahub/data.json temp_data.json; then
  echo "No changes; data has not changed"
  rm temp_data.json
  exit 0
else
  mv temp_data.json datahub/data.json
  echo "Data updated in datahub/data.json"
fi


