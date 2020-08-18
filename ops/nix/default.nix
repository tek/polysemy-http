{
  base,
}:
let
  hsSrc = fetchTarball "https://gitlab.tryp.io/nix/hs/-/archive/a1e7b43e1270518c9af311c736349c56f226e73c.tar.gz";
  # hsSrc = ../../../../nix/tryp-hs;
  hs = import hsSrc { inherit base; };
  packages = { polysemy-http = base + /packages/polysemy-http; };
  project = hs.project {
    inherit packages base;
    compiler = "ghc8101";
    overrides = import ./overrides.nix;
    ghciArgs = ["-hide-package" "base"];
    cabal2nixOptions = "--no-hpack";
    options_ghc = "-fplugin=Polysemy.Plugin";
  };
  tags = hs.util.tags { packages = project.sets.all; inherit (project) ghc; packageDir = "packages"; };
in tags // project
