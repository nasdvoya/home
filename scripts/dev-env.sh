#!/bin/bash

# Function to check for .sln file and run nix develop if not already in nix-shell
check_sln_and_nix_develop() {
  if [ -f ".sln" ]; then
    if [ -z "$IN_NIX_SHELL" ]; then
      echo "Found .sln file, running 'nix develop'..."
      nix develop
    else
      echo "Already in a nix-shell environment, skipping 'nix develop'."
    fi
  fi
}

# Hook function to the prompt command
export PROMPT_COMMAND=check_sln_and_nix_develop

