#!/usr/bin/env nix-shell
#!nix-shell -i zsh -p haskellPackages.hpack

setopt err_exit no_unset

args=$*
base=${0:a:h:h}

gen()
{
  pushd $1
  hpack $args
  popd
}

for m ($base/packages/*) gen $m
