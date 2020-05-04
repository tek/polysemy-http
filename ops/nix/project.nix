{
  pkgs ? import <nixpkgs> {},
  base ? ../..,
}:
let
  lib = pkgs.lib;

  all = {
    http-client-polysemy = base + /packages/http-client-polysemy;
  };
in {
  packages = {
    all = rec {
      dirMap = lib.attrsets.mapAttrs (_: p: baseNameOf p) all;
      dirNames = lib.attrsets.attrValues dirMap;
      abs = all;
      absPaths = lib.attrsets.attrValues abs;
      names = lib.attrsets.attrNames all;
    };
  };
}
