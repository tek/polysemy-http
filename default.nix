let
  base = ./.;
  hs = import (fetchTarball "https://gitlab.tryp.io/nix/hs/-/archive/73f31bf2bc306cc17564b601f40a59acfaf1311f.tar.gz");
  packages = { http-client-polysemy = base + /packages/http-client-polysemy; };
  overrides = import ./ops/nix/overrides.nix { inherit (hs) hackage; };
  project = hs.project {
    inherit packages overrides base;
    ghciArgs = ["-hide-package" "base"];
    cabal2nixOptions = "--no-hpack";
    options_ghc = "-fplugin=Polysemy.Plugin";
  };
  tags = import ./ops/nix/tags.nix { inherit (project) compiler; packages = project.sets.all; pkgs = project.pkgs; };
in tags // project
