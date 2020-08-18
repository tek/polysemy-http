{
  base,
}:
let
  # hsSrc = fetchTarball "https://gitlab.tryp.io/nix/hs/-/archive/a38d2e20468e84e17249330bc38b60e17910cc07.tar.gz";
  hsSrc = ../../../../nix/tryp-hs;
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
