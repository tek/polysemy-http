{
  description = "Polysemy effect for http-client";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/cfed29bfcb28259376713005d176a6f82951014a;
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
    polysemy-log = {
      url = github:tek/polysemy-log;
      flake = false;
    };
    polysemy-time = {
      url = github:tek/polysemy-time;
      flake = false;
    };
  };

  outputs = { self, nixpkgs, tryp-hs, flake-utils, ... }@inputs:
  flake-utils.lib.eachSystem ["x86_64-linux"] (system:
    let
      project = tryp-hs.project {
        inherit system;
        base = ./.;
        compiler = "ghc8102";
        packages = { polysemy-http = "packages/polysemy-http"; };
        overrides = import ./ops/nix/overrides.nix inputs;
        ghci = {
          basicArgs = ["-Wall" "-Werror"];
          options_ghc = "-fplugin=Polysemy.Plugin";
        };
        ghcid.prelude = "packages/polysemy-http/lib/Prelude.hs";
        packageDir = "packages";
        cabal2nixOptions = "--no-hpack";
      };
    in {
      defaultPackage = project.ghc.polysemy-http;
      devShell = project.ghcid-flake.shell;
      legacyPackages = {
        run = project.ghcid-flake.run;
        cabal = project.cabal;
        tags = project.tags.projectTags;
        hpack = project.hpack-script {};
      };
      packages = {
        polysemy-http = project.ghc.polysemy-http;
      };
    }
  );
}
