{
  description = "Polysemy effects for HTTP clients";

  inputs = {
    hix.url = "git+https://git.tryp.io/tek/hix";
    prelate.url = "git+https://git.tryp.io/tek/prelate";
  };

  outputs = { hix, prelate, ... }: hix.lib.pro ({config, ...}: {
    hackage.versionFile = "ops/version.nix";
    deps = [prelate];

    cabal = {
      license = "BSD-2-Clause-Patent";
      license-file = "LICENSE";
      author = "Torsten Schmits";
      prelude = {
        enable = true;
        package = {
          name = "prelate";
          version = "^>= 0.6";
        };
        module = "Prelate";
      };
      paths = false;
      meta = {
        maintainer = "hackage@tryp.io";
        category = "Network";
        extra-source-files = ["readme.md" "changelog.md"];
        github = "tek/polysemy-http";
      };
      dependencies = ["polysemy ^>= 1.9" "polysemy-plugin ^>= 0.4"];
      ghc-options = ["-fplugin=Polysemy.Plugin"];
    };

    overrides = { hackage, source, ... }: {
      prelate = hackage "0.6.0.0" "01f1xylbzkrmn5f7r3z6idrb6lx6j3ywgnq9bv6cg8kssnj62azk";
    };

    packages.polysemy-http = {
      src = ./packages/polysemy-http;
      cabal.meta.synopsis = "Polysemy effects for HTTP clients";

      library = {
        enable = true;
        dependencies = [
          "aeson >= 1.4 && < 2.2"
          "case-insensitive ^>= 1.2"
          "exon ^>= 1.4"
          "http-client >= 0.5.14 && < 0.8"
          "http-client-tls ^>= 0.3.1"
          "http-types ^>= 0.12.3"
          "time"
        ];
      };

      test = {
        enable = true;
        dependencies = [
          "exon ^>= 1.4"
          "hedgehog >= 1.1 && < 1.3"
          "http-client >= 0.5.14 && < 0.8"
          "tasty ^>= 1.4"
          "tasty-hedgehog >= 1.3 && < 1.5"
        ];
      };

      tests.integration = {
        dependencies = [
          "aeson >= 1.4 && < 2.2"
          "exon ^>= 1.4"
          "hedgehog >= 1.1 && < 1.3"
          "http-client >= 0.5.14 && < 0.8"
          "network ^>= 3.1"
          "servant-server ^>= 0.19"
          "servant-client ^>= 0.19"
          "tasty ^>= 1.4"
          "tasty-hedgehog >= 1.3 && < 1.5"
          "warp ^>= 3.3"
        ];
      };

    };
  });
}
