{
  compiler,
  pkgs,
  project,
  ghci,
}:
let
  inherit (project) packages;
  lib = pkgs.lib;
  ghc = pkgs.haskell.packages.${compiler};

  restarts =
    map (m: "--restart='${m}/package.yaml'");

  testMod =
    pkg: type: "packages/${pkg}/${type}";

  ghcidCmd =
    packages: command: test:
    "ghcid -W --reload=config ${toString (restarts packages)} --command='${command}' --test='${test}'";

  ghcidCmdFile =
    packages: command: test:
    pkgs.writeScript "ghcid-cmd" (ghcidCmd packages command test);

  shell =
    ghc.shellFor {
      packages = p: [p.http-client-polysemy];
      buildInputs = [ghc.ghcid ghc.cabal-install];
    };

  allDirs =
    packages.all.dirNames;

  allPaths =
    packages.all.absPaths;

  commands = {
    test =
      pkg: module: name: type:
      let
        script =
          ghci.scripts.test module name;
      in
        ghcidCmdFile allPaths (ghci.command allDirs script [(testMod pkg type)]) (ghci.tests.test name);
  };
in {
  inherit ghci commands shell;
  test =
    { pkg, module, name, type }:
    shell.overrideAttrs (_: { shellHook = commands.test pkg module name type; });
  ghcide-conf =
    builtins.concatStringsSep "\n" (ghci.ghcide-conf packages.all.dirNames);
}
