{
  description = "Polysemy effects for HTTP clients";

  inputs = {
    hix.url = git+https://git.tryp.io/tek/hix;
    prelate.url = git+https://git.tryp.io/tek/prelate;
  };

  outputs = { hix, prelate, ... }:
  let

    all = { hackage, source, ... }: {
      prelate = hackage "0.5.0.0" "0zs75i3ij4a82aqk4i324nrn5g3vclkspgrd8qdm9jj73pvq8za5";
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
    compat.projects."943".enable = false;
  });
}
