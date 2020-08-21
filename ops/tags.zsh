#!/usr/bin/env zsh

setopt err_exit no_unset

output=$1
tags=$(nix-build --no-link -A tags.projectTags $@[2,$])
cp $tags/tags $output
chmod u+w $output
