#!/bin/bash
# Create a new personal note

# Check if the first argument is provided
if [ -z "$1" ]; then
  echo "Error: A file name must be set, e.g., 'the wonderful thing about tiggers'."
  exit 1
fi

# Replace spaces with hyphens and prepend the current date
file_name=$(echo "$1" | tr ' ' '-')
formatted_file_name=$(date "+%Y-%m-%d")_${file_name}.md

# Change to the specified directory, or exit if it fails
cd "${HOME}/github/notes" || exit

touch "inbox/${formatted_file_name}"
nvim "inbox/${formatted_file_name}"
