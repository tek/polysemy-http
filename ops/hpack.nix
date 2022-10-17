{ config, lib, ... }:
with builtins;
with lib;
let

  mergeAttr = a: b:
  if isAttrs a
  then merge a b
  else if isList a
  then a ++ b
  else b;

  merge = l: r:
  let
    f = name:
    if hasAttr name l && hasAttr name r
    then mergeAttr l.${name} r.${name}
    else l.${name} or r.${name};
  in genAttrs (concatMap attrNames [l r]) f;

  paths = name: {
    when = {
      condition = false;
      generated-other-modules = ["Paths_${replaceStrings ["-"] ["_"] name}"];
    };
  };

  meta = {
    version = import ./version.nix;
    license = "BSD-2-Clause-Patent";
    license-file = "LICENSE";
    author = "Torsten Schmits";
    maintainer = "hackage@tryp.io";
    copyright = "2022 Torsten Schmits";
    category = "Network";
    build-type = "Simple";
    git = "https://git.tryp.io/tek/polysemy-http";
    homepage = "https://git.tryp.io/tek/polysemy-http";
    bug-reports = "https://git.tryp.io/tek/polysemy-http/issues";
  };

  options.ghc-options = [
    "-Wall"
    "-Wredundant-constraints"
    "-Wincomplete-uni-patterns"
    "-Wmissing-deriving-strategies"
    "-Widentities"
    "-Wunused-packages"
    "-fplugin=Polysemy.Plugin"
  ];

  dependencies = [
    { name = "base"; version = ">= 4.12 && < 5"; mixin = "hiding (Prelude)"; }
    { name = "prelate"; version = "^>= 0.2"; mixin = ["(Prelate as Prelude)" "hiding (Prelate)"]; }
    "polysemy >= 1.6"
    "polysemy-plugin >= 0.4"
  ];

  project = name: doc: merge (meta // { library = paths name; } // options) {
    inherit name;
    description = "See https://hackage.haskell.org/package/${name}/docs/${doc}.html";
    library = {
      source-dirs = "lib";
      inherit dependencies;
    };
    default-extensions = config.ghci.extensions;
  };

  exe = pkg: dir: merge (paths pkg // {
    main = "Main.hs";
    source-dirs = dir;
    dependencies = dependencies ++ [pkg];
    ghc-options = [
      "-threaded"
      "-rtsopts"
      "-with-rtsopts=-N"
    ];
  });

in {

  polysemy-http = merge (project "polysemy-http" "Polysemy-Http") {
    synopsis = "Polysemy effects for HTTP clients";
    extra-source-files = ["changelog.md" "readme.md"];
    library.dependencies = [
      "aeson >= 1.4"
      "case-insensitive >= 1.2"
      "exon >= 0.3"
      "http-client >= 0.5.14"
      "http-client-tls >= 0.3.1"
      "http-types >= 0.12.3"
      "time"
    ];
    tests.polysemy-http-unit = exe "polysemy-http" "test" {
      dependencies = [
        "exon"
        "hedgehog"
        "http-client"
        "tasty"
        "tasty-hedgehog"
      ];
    };
    tests.polysemy-http-integration = exe "polysemy-http" "integration" {
      dependencies = [
        "aeson"
        "exon"
        "hedgehog"
        "http-client"
        "network"
        "servant-server"
        "servant-client"
        "tasty"
        "tasty-hedgehog"
        "warp"
      ];
    };
  };

}
