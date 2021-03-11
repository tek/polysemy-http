{
  description = "Polysemy effect for http-client";
  inputs = {
    nixpkgs.url = github:NixOs/nixpkgs/cfed29bfcb28259376713005d176a6f82951014a;
    flake-utils.url = github:numtide/flake-utils;
    tryp-hs.url = github:tek/tryp-hs;
    # tryp-hs.url = path:/home/tek/code/tek/nix/tryp-hs;
    tryp-hs.inputs.nixpkgs.follows = "nixpkgs";
    co-log = {
      url = github:kowainik/co-log;
      flake = false;
    };
    polysemy = {
      url = github:polysemy-research/polysemy;
      flake = false;
    };
  };
  outputs = { self, nixpkgs, tryp-hs, flake-utils, ... }@inputs:
  flake-utils.lib.eachDefaultSystem (system:
    let
      base = ./.;
      packages = { polysemy-http = ./packages/polysemy-http; };
      project = tryp-hs.project {
        inherit base packages system;
        compiler = "ghc8102";
        overrides = import ./ops/nix/overrides.nix inputs;
        ghci = {
          basicArgs = ["-Wall" "-Werror"];
          options_ghc = "-fplugin=Polysemy.Plugin";
        };
        ghcid.prelude = ./packages/polysemy-http/lib/Prelude.hs;
        packageDir = "packages";
        cabal2nixOptions = "--no-hpack";
      };
    in project // {
      defaultPackage = project.ghc.polysemy-http;
      devshell = import ./ops/nix/shell.nix { inherit project; };
    }
  );
}
