niv:
{
  pkgs,
  hackage,
}:
self: super:
let
  inherit (hackage) pack cabal2nix subPkg github;

  versions = [
    (pack "servant" "0.18" "1mwwqn012kwjigckka6msiwpxp8wracc55nk01y6hj9n8ndmnrm5")
    (pack "servant-client" "0.18" "0q8l3s92cg3d1350xx1fpz5z3z2wg61iyzg35gzw4yqwwi78k3fb")
    (pack "servant-client-core" "0.18" "1id3rjixdshlj57cdl1zxrrf2h8idvmcb2grlskxiq444iwc7alp")
    (pack "servant-server" "0.18" "0h4nkxxi5r0y1883ixlmirnx2avl666x2nid4lqgkzwsk0cjrbpm")
  ];
  versionOverrides = builtins.listToAttrs versions;

  custom = {
    co-log-polysemy = subPkg "co-log-polysemy" "co-log-polysemy" niv.co-log;
    polysemy = cabal2nix "polysemy" niv.polysemy;
    polysemy-plugin = subPkg "polysemy-plugin" "polysemy-plugin" niv.polysemy;
  };
in
  versionOverrides // custom
