{
  ghcid,
}:
let
  buildDir = "/tmp/polysemy-http-build";
  bd = "--builddir  ${buildDir}";
  shell = cmd:
  ghcid.shellWith {
    hook = ''
      ops/hpack.zsh
      ${cmd}
      exit
    '';
  };
  command = args:
  shell "cabal ${args}";
  pkgCommand = args:
  command "${args} ${bd} polysemy-http";
  docOptions = "--enable-documentation --haddock-for-hackage --haddock-options '--hide Paths_polysemy_http'"
in {
  build = pkgCommand "v2-build ${docOptions}";
  doc = pkgCommand "v2-haddock ${docOptions}";
  sdist = pkgCommand "v2-sdist -o ${buildDir}";
  uploadSrc = command "upload ${buildDir}/polysemy-http-?.?.?.?.tar.gz";
  uploadDoc = command "upload -d ${buildDir}/*docs.tar.gz";
  publish = command "upload --publish ${buildDir}/polysemy-http-?.?.?.?.tar.gz";
}
