{
  description = "Polysemy Effect for HTTP Clients";

  inputs.hix.url = github:tek/hix;
  inputs.incipit.url = github:tek/incipit;

  outputs = { hix, incipit, ... }:
  let

    all = { hackage, ... }: {
      exon = hackage "0.3.0.0" "0jgpj8818nhwmb3271ixid38mx11illlslyi69s4m0ws138v6i18";
      flatparse = hackage "0.3.2.0" "01w71985b9ndg4wkfxqxjj7f1cynji6vp71akr7ivpmxn2drxspa";
    };

  in
  hix.lib.flake {
    base = ./.;
    packages.polysemy-http = ./packages/polysemy-http;
    overrides = { inherit all; };
    deps = [incipit];
    compat.projects = {
      "902" = {};
      "884" = {};
    };
    ghci.args = ["-fplugin=Polysemy.Plugin"];
    hackage.versionFile = "ops/hpack/packages/polysemy-http.yaml";
    ghci.preludePackage = "incipit";
  };
}
