#!/usr/bin/env nix-shell
#!nix-shell -i zsh -p haskellPackages.hpack

setopt err_exit no_unset

args=$*
base=${0:a:h:h}

gen()
{
  pushd $base/$1
  hpack $args
  popd
}

for m (${0:h:h}/packages/*) gen $m
