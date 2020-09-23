niv:
{
  pkgs,
  hackage,
}:
self: super:
let
  inherit (hackage) pack thunk cabal2nix subPkg github;

  versions = [
    (pack "co-log-polysemy" "0.0.1.2" "17bcs8dvrhwfcyklknkqg11gxgxm2jaa7kbm6xx4vm1976abzwss")
    (pack "first-class-families" "0.8.0.0" "0266lqagnxmd80n9i0f1xsh4zfrmab5aazyp4ii5nqch3474gpm6")
    (pack "servant" "0.18" "1mwwqn012kwjigckka6msiwpxp8wracc55nk01y6hj9n8ndmnrm5")
    (pack "servant-client" "0.18" "0q8l3s92cg3d1350xx1fpz5z3z2wg61iyzg35gzw4yqwwi78k3fb")
    (pack "servant-client-core" "0.18" "1id3rjixdshlj57cdl1zxrrf2h8idvmcb2grlskxiq444iwc7alp")
    (pack "servant-server" "0.18" "0h4nkxxi5r0y1883ixlmirnx2avl666x2nid4lqgkzwsk0cjrbpm")
    (pack "string-interpolate" "0.3.0.1" "0fmzv54xx56hm85kj01n3zp6cd7j39flmzdkha0ldw804xlas3lv")
  ];
  versionOverrides = builtins.listToAttrs versions;

  custom = {
    polysemy = cabal2nix "polysemy" niv.polysemy;
    polysemy-plugin = subPkg "polysemy-plugin" "polysemy-plugin" niv.polysemy;
  };
in
  versionOverrides // custom
