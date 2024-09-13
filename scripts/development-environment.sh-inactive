#!/bin/bash

development-environment() {
  if ls *.sln 1> /dev/null 2>&1 && [ ! -f flake.nix ]; then
    # Check if not already in a nix-shell environment and if the command hasn't been run yet
    if [ -z "$IN_NIX_SHELL" ] && [ -z "$DEV_ENV_RAN" ]; then
      # Run nix develop with the GitHub flake and set the DEV_ENV_RAN flag
      export DEV_ENV_RAN=1
      nix develop github:nasdvoya/flake-dotnet
    fi
  elif [ -f flake.nix ]; then
    nix develop
  fi
}

development-environment
