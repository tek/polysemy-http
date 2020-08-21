niv:
{
  pkgs,
  hackage,
}:
self: super:
let
  inherit (hackage) pack thunk cabal2nix subPkg github;

  versions = [
  ];
  versionOverrides = builtins.listToAttrs versions;

  custom = {
    polysemy = cabal2nix "polysemy" niv.polysemy;
    polysemy-plugin = subPkg "polysemy-plugin" "polysemy-plugin" niv.polysemy;
  };
in
  versionOverrides // custom
