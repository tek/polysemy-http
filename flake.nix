{
  description = "Polysemy effects for HTTP clients";

  inputs = {
    hix.url = git+https://git.tryp.io/tek/hix;
    prelate.url = git+https://git.tryp.io/tek/prelate;
    exon.url = git+https://git.tryp.io/tek/exon;
  };

  outputs = { hix, prelate, exon, ... }:
  let

    all = { hackage, source, ... }: {
      exon = hackage "1.2.0.0" "0il7167fk6bk2ahza2cpzhdjkyvdzwcwfdqcqaxhsv7nj6hckg5l";
      flatparse = hackage "0.3.5.1" "0gbn93jnmj0x8akcani59ivnqzyyv1mzw0jmmc3pfklq7x9b17cm";
      prelate = hackage "0.1.0.0" "1596kh9hks9na607dr5pqlm1vpj07gn9viwxp319s57d06wh9s5h";
    };

  in
  hix.lib.pro ({config, lib, ...}: {
    packages.polysemy-http = ./packages/polysemy-http;
    overrides = { inherit all; };
    deps = [prelate exon];
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
