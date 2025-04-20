{
  description = "Polysemy effects for HTTP clients";

  inputs = {
    hix.url = "git+https://git.tryp.io/tek/hix";
    prelate.url = "git+https://git.tryp.io/tek/prelate";
  };

  outputs = { hix, prelate, ... }: hix.lib.pro ({config, lib, ...}: let

    jailbreaks910 = {hackage, jailbreak, unbreak, ...}: {
      bytebuild = jailbreak;
      chronos = jailbreak;
      incipit = jailbreak;
      incipit-base = jailbreak;
      incipit-core = jailbreak;
      polysemy-chronos = jailbreak;
      polysemy-conc = jailbreak;
      polysemy-log = jailbreak;
      polysemy-process = jailbreak unbreak;
      polysemy-resume = jailbreak;
      polysemy-test = jailbreak unbreak;
      polysemy-time = jailbreak;
    };

    overrides910 = api@{hackage, jailbreak, unbreak, ...}: jailbreaks910 api // {
      byte-order = jailbreak;
      exon = hackage "1.7.1.0" "16vf84nnpivxw4a46g7jsy2hg4lpla7grkv3gp8nd69zlv43777l";
      prelate = hackage "0.8.0.0" "0id72rbynmbb15ld8pv8nijll3k50x2mrpcqsv8dkbs7q05fn9vg";
    };

  in {
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
      latest.compiler = "ghc910";
    };

    envs.ghc910.overrides = overrides910;

    overrides = {hackage, ...}: {
      prelate = hackage "0.8.0.0" "0id72rbynmbb15ld8pv8nijll3k50x2mrpcqsv8dkbs7q05fn9vg";
    };

  });
}
