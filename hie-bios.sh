#!/usr/bin/env bash

nix eval --raw -f default.nix ghcid.ghcide-conf > "$HIE_BIOS_OUTPUT"
