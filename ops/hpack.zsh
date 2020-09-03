#!/usr/bin/env nix-shell
#!nix-shell -i zsh -p haskellPackages.hpack

setopt err_exit no_unset

base=${0:a:h:h}
hpack="$base/ops/hpack"

gen()
{
  local dir=$1
  pushd $dir
  cp $hpack/packages/${dir:t}.yaml $dir/package.yaml
  ln -srf $hpack/shared $dir/shared
  trap "rm -f $dir/package.yaml $dir/shared" EXIT
  hpack 1>/dev/null
  popd
}

for m ($base/packages/*) gen $m
