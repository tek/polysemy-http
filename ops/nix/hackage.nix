{ pkgs }: self: super:
let
  unbreak = pkgs.haskell.lib.unmarkBroken;
  notest = p:
    pkgs.haskell.lib.dontBenchmark (pkgs.haskell.lib.dontCheck (unbreak p));
  jailbreak = pkgs.haskell.lib.doJailbreak;
  hackage = { pkg, ver, sha256 }:
    notest (self.callHackageDirect { inherit pkg ver sha256; } {});
in {
  inherit unbreak notest jailbreak hackage;
  pack = pkg: ver: sha256:
    { name = pkg; value = hackage { inherit pkg ver sha256; }; };
  jpack = pkg: ver: sha256:
    { name = pkg; value = jailbreak (hackage { inherit pkg ver sha256; }); };
  unbreakSuper = name: notest (builtins.getAttr name super);
}
