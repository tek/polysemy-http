{
  base,
}:
let
  niv = import "${toString base}/nix/sources.nix";
  nixpkgsSrc = niv.nixpkgs;
  # hsSrc = ../../../../nix/tryp-hs;
  hsSrc = niv.tryp-hs;

  nixpkgs = import nixpkgsSrc;
  hs = import hsSrc { inherit base; };

  packages = { polysemy-http = base + /packages/polysemy-http; };

  project = hs.project {
    inherit nixpkgs packages base;
    compiler = "ghc884";
    overrides = import ./overrides.nix niv;
    ghci = {
      basicArgs = ["-Wall" "-Werror"];
      options_ghc = "-fplugin=Polysemy.Plugin";
    };
    ghcid = {
      prelude = "${toString base}/packages/polysemy-http/lib/Prelude.hs";
    };
    packageDir = "packages";
    cabal2nixOptions = "--no-hpack";
  };
in
  project
