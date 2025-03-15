{
  description = "Polysemy effects for HTTP clients";

  inputs = {
    hix.url = "git+https://git.tryp.io/tek/hix";
    prelate.url = "git+https://git.tryp.io/tek/prelate";
  };

  outputs = { hix, prelate, ... }: hix.lib.pro ({config, lib, ...}: {
    ghcVersions = ["ghc94" "ghc96" "ghc98" "ghc910"];
    hackage.versionFile = "ops/version.nix";
    deps = [prelate];
    gen-overrides.enable = true;

    packages.polysemy-http = {
      src = ./packages/polysemy-http;
      cabal.meta.synopsis = "Polysemy effects for HTTP clients";

      library = {
        enable = true;
        dependencies = [
          "aeson"
          "case-insensitive"
          "exon"
          "http-client"
          "http-client-tls"
          "http-types"
          "time"
        ];
      };

      test = {
        enable = true;
        dependencies = [
          "exon"
          "hedgehog"
          "http-client"
          "tasty"
          "tasty-hedgehog"
        ];
      };

      tests.integration = {
        dependencies = [
          "aeson"
          "exon"
          "hedgehog"
          "http-client"
          "network"
          "polysemy-test"
          "servant"
          "servant-server"
          "servant-client"
          "tasty"
          "tasty-hedgehog"
          "warp"
        ];
      };

    };

    cabal = {
      license = "BSD-2-Clause-Patent";
      license-file = "LICENSE";
      author = "Torsten Schmits";
      prelude = {
        enable = true;
        package = "prelate";
        module = "Prelate";
      };
      paths = false;
      meta = {
        maintainer = "hackage@tryp.io";
        category = "Network";
        extra-source-files = ["readme.md" "changelog.md"];
        github = "tek/polysemy-http";
      };
      dependencies = ["polysemy" "polysemy-plugin"];
      ghc-options = ["-fplugin=Polysemy.Plugin"];
      default-extensions = ["StrictData"];
    };

    managed = {
      enable = true;
      lower.enable = true;
      latest.compiler = "ghc98";
      envs.solverOverrides = {hackage, jailbreak, unbreak, ...}: {
        incipit = jailbreak;
        polysemy-test = jailbreak unbreak;
        polysemy-conc = jailbreak;
        polysemy-log = jailbreak;
        polysemy-process = unbreak;
        prelate = hackage "0.8.0.0" "0id72rbynmbb15ld8pv8nijll3k50x2mrpcqsv8dkbs7q05fn9vg";
      };
    };

    envs.latest.overrides = {hackage, jailbreak, unbreak, ...}: {
      incipit = jailbreak;
      polysemy-test = jailbreak unbreak;
      polysemy-conc = jailbreak;
      polysemy-log = jailbreak;
      polysemy-process = unbreak;
      prelate = hackage "0.8.0.0" "0id72rbynmbb15ld8pv8nijll3k50x2mrpcqsv8dkbs7q05fn9vg";
    };

    envs.lower.overrides = {hackage, jailbreak, unbreak, ...}: {
      polysemy-test = jailbreak unbreak;
      polysemy-process = unbreak;
      prelate = hackage "0.8.0.0" "0id72rbynmbb15ld8pv8nijll3k50x2mrpcqsv8dkbs7q05fn9vg";
    };

    overrides = {hackage, ...}: {
      prelate = hackage "0.8.0.0" "0id72rbynmbb15ld8pv8nijll3k50x2mrpcqsv8dkbs7q05fn9vg";
    };

  });
}
