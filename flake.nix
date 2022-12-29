{
  description = "Polysemy effects for HTTP clients";

  inputs = {
    hix.url = git+https://git.tryp.io/tek/hix;
    prelate.url = git+https://git.tryp.io/tek/prelate;
  };

  outputs = { hix, prelate, ... }:
  let

    all = { hackage, source, ... }: {
      prelate = hackage "0.4.0.0" "0sxvyf3wj0nvn1svnl90ninawfmzyr432k1lv14b15h22bi0kawd";
    };

  in
  hix.lib.pro ({config, lib, ...}: {
    packages.polysemy-http = ./packages/polysemy-http;
    overrides = { inherit all; };
    deps = [prelate];
    devGhc.compiler = "ghc902";
    hpack.packages = import ./ops/hpack.nix { inherit config lib; };
    hackage.versionFile = "ops/version.nix";
    ghci = {
      args = ["-fplugin=Polysemy.Plugin"];
      preludePackage = "prelate";
      preludeModule = "Prelate";
    };
  });
}
