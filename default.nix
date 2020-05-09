let
  base = ./.;
  hs = import (fetchTarball "https://gitlab.tryp.io/nix/hs/-/archive/6adb10787ecb3de38ecbb6a8a3bc3ae6c93f3f67.tar.gz");
  packages = { http-client-polysemy = base + /packages/http-client-polysemy; };
  overrides = import ./ops/nix/overrides.nix { inherit base; inherit (hs) hackage; };
  project = hs.project {
    inherit packages overrides base;
    ghciArgs = ["-hide-package" "base"];
    cabal2nixOptions = "--no-hpack";
  };
  tags = import ./ops/nix/tags.nix { inherit (project) compiler; packages = project.sets.all; pkgs = project.pkgs; };
in tags // project
