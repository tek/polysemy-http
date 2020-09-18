#!/usr/bin/env zsh

setopt err_exit no_unset

pkg=$1 module=$2 name=$3 type_=$4 runner=$5
${0:h:h}/hpack.zsh
nix-shell $*[6,$] --pure -A 'ghcid.run' \
  --argstr pkg $pkg \
  --argstr module $module \
  --argstr name $name \
  --argstr 'type' $type_ \
  --argstr 'runner' $runner \
  --run exit
