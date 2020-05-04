{
  pkgs ? import <nixpkgs> {},
  project ? import ./project.nix { inherit pkgs; },
}:
let
  libDir = m: "packages/${m}/lib";
  colonSeparated =
    builtins.concatStringsSep ":";
  searchPaths =
    paths:
    "-i${colonSeparated paths}";
in rec {
  args = {
    basic =
      ["-no-user-package-db" "-package-env" "-" "-hide-package" "base"];

    preprocessor =
      ["-F" "-pgmF" ../dev/preprocessor.zsh];
  };

  scripts = {
    test = module: test: pkgs.writeText "ghci-script-test" ''
      :load ${module}
      import ${module}
      import Hedgehog (check)
    '';
  };

  tests = {
    test =
      name:
      if name == "main"
      then name
      else "check ${name}";
  };

  command =
    packages: script: extraSearch:
    let
      basic = toString args.basic;
      preproc = toString args.preprocessor;
      search = searchPaths ((map libDir packages) ++ extraSearch);
    in
    "ghci ${basic} ${preproc} ${search} -ghci-script ${script}";

  ghcide-conf =
    packages:
    args.basic ++ args.preprocessor ++ [(searchPaths (map libDir packages))];
}
