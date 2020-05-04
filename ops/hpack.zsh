#!/usr/bin/env zsh

setopt err_exit no_unset

gen()
{
  pushd $1
  hpack
  popd
}

for m (${0:h:h}/packages/*) gen $m
