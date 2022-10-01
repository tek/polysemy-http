{
  description = "Polysemy effects for HTTP clients";

  inputs = {
    hix.url = git+https://git.tryp.io/tek/hix;
    prelate.url = git+https://git.tryp.io/tek/prelate;
  };

  outputs = { hix, prelate, ... }:
  let

    dev = { hackage, source, ... }: {
      prelate = source.package prelate "prelate";
    };

    all = { hackage, source, ... }: {
      prelate = hackage "0.1.0.0" "1596kh9hks9na607dr5pqlm1vpj07gn9viwxp319s57d06wh9s5h";
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
