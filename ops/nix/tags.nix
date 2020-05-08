{
  packages,
  pkgs,
  compiler,
}:
let
  tags = import (fetchTarball "https://github.com/tek/thax/tarball/master") { inherit pkgs; };
  withPrefix =
    name: dir: pkgs.haskell.packages.${compiler}.${name} // { tagsPrefix = "packages/${dir}"; };
  targets =
    pkgs.lib.attrsets.mapAttrsToList withPrefix packages.byPath;
in {
  projectTags =
    tags.combined.all { inherit targets; };
}
