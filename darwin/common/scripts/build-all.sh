#!/usr/bin/env bash

# if nh-home is in the PATH then use it
if command -v nh-home &> /dev/null; then
    nh-home build
else
    nix run nixpkgs#home-manager -- build --flake "$HOME/nixos-config" -L
fi
build-host
