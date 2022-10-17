{
  description = "Polysemy effects for HTTP clients";

  inputs = {
    hix.url = git+https://git.tryp.io/tek/hix;
    prelate.url = git+https://git.tryp.io/tek/prelate;
  };

  outputs = { hix, prelate, ... }:
  let

    dev = { hackage, source, ... }: {
    };

    all = { hackage, source, ... }: {
      prelate = hackage "0.2.0.0" "1wnjik3xkyxvzs6r4iadvdjwkms8cxzh0qccfafb25yv4ma6xng6";
    };

  in
  hix.lib.pro ({config, lib, ...}: {
    packages.polysemy-http = ./packages/polysemy-http;
    overrides = { inherit all dev; };
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
