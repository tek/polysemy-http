{
  hackage,
}:
self: super:
let
  pkgs = self.callPackage ({pkgs, ...}: pkgs) {};
  hack = hackage { inherit pkgs self super; };
  inherit (hack) pack;
  versions = [
    (pack "polysemy" "1.3.0.0" "1p75i56qpl0v79vrlzw04117czzgwhn1l0vadvka8m7drmcvwsf6")
    (pack "co-log-polysemy" "0.0.1.1" "0frp0p4nk37vdqmgnw851v6z1185rhvwsfl973dc1gw4jvmfd8b8")
    (pack "polysemy-plugin" "0.2.5.0" "0jnps8kwxd0hakis5ph77r45mv1qnkxdf5506shcjb1zmxqmxpjv")
  ];
  versionOverrides = builtins.listToAttrs versions;
in versionOverrides
