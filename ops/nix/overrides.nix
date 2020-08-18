{
  pkgs,
  hackage,
}:
self: super:
let
  inherit (hackage) pack thunk cabal2nix subPkg github;

  base-noprelude = github {
    owner = "tek";
    repo = "base-noprelude";
    rev = "d6ad765adca25c2efb06110dae854113fe1cd733";
    sha256 = "0ffv2i29q05p5jza2jl1jzrfg0z7z6fw4ix7ay4h4ppzkzakk0ib";
  };

  versions = [
  ];
  versionOverrides = builtins.listToAttrs versions;

  polysemySrc = thunk "polysemy";
  custom = {
    inherit base-noprelude;
    polysemy = cabal2nix "polysemy" polysemySrc;
    polysemy-plugin = subPkg "polysemy-plugin" "polysemy-plugin" polysemySrc;
  };
in
  versionOverrides // custom
