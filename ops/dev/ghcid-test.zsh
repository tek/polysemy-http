#!/usr/bin/env zsh

setopt err_exit no_unset

pkg=$1 module=$2 name=$3 type_=$4
${0:h:h}/hpack.zsh
nix-shell --pure -A 'ghcid.test' \
  --argstr pkg $pkg \
  --argstr module $module \
  --argstr name $name \
  --argstr 'type' $type_ \
  --run exit
