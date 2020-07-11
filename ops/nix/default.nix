{
  base,
}:
let
  hs = import (fetchTarball "https://gitlab.tryp.io/nix/hs/-/archive/9ca9ed9b741508edb96c397197cebf7da417b3d5.tar.gz");
  packages = { http-client-polysemy = base + /packages/http-client-polysemy; };
  overrides = import ./overrides.nix { inherit (hs) hackage; };
  project = hs.project {
    inherit packages overrides base;
    ghciArgs = ["-hide-package" "base"];
    cabal2nixOptions = "--no-hpack";
    options_ghc = "-fplugin=Polysemy.Plugin";
  };
  tags = hs.tags { packages = project.sets.all; inherit (project) ghc; packageDir = "packages"; };
in tags // project
