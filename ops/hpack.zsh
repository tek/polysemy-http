#!/usr/bin/env zsh

setopt err_exit

base=${0:a:h:h}

script=$(nix-build -A legacyPackages.x86_64-linux.hpack)
$script $base
