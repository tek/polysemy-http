{
  nixpkgs ? import <nixpkgs>,
}:
let
  tryp = import (fetchTarball "https://gitlab.tryp.io/nix/hs/-/archive/2089571474cae1fa4e5144c6384e719f9b7693f5.tar.gz");
  base = ./.;
  packages = { http-client-polysemy = base + /packages/http-client-polysemy; };
  overrides = import ./ops/nix/overrides.nix { inherit base; inherit (tryp) hackage; };
  project = tryp.project {
    inherit packages overrides base;
    ghciArgs = ["-hide-package" "base"];
    cabal2nixOptions = "--no-hpack";
  };
  tags = import ./ops/nix/tags.nix { inherit (project) compiler; packages = project.sets.all; pkgs = project.pkgs; };
in tags // project
