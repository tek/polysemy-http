{
  description = "Polysemy effect for http-client";

  inputs.hix.url = github:tek/hix;

  outputs = { hix, ... }:
  let
    common = { hackage, jailbreak, ... }: {
      co-log = jailbreak (hackage "0.4.0.1" "05f37lq1kwlmm62n1n932l8jnqirmlf87var2n2zb0cslmv63yxg");
      co-log-polysemy = jailbreak (hackage "0.0.1.2" "17bcs8dvrhwfcyklknkqg11gxgxm2jaa7kbm6xx4vm1976abzwss");
      polysemy = hackage "1.5.0.0" "1xl472xqdxnp4ysyqnackpfn6wbx03rlgwmy9907bklrh557il6d";
      polysemy-conc = hackage "0.1.0.2" "0ijz5l8q53d1s7i100gvjdhzv80dpd140m7a9hyam113ybglc8lg";
      polysemy-log = hackage "0.2.2.1" "1c8kn28a5j9k52jfg5n6nb4ywd76mgrgaqwmf1q0km2kgdi9y40s";
      polysemy-plugin = hackage "0.3.0.0" "1frz0iksmg8bpm7ybnpz9h75hp6hajd20vpdvmi04aspklmr6hj0";
      polysemy-test = hackage "0.3.1.1" "0x0zg1kljr7a1mwmm3zrmha5inz3l2pkldnq65fvsig8f3x8rsar";
      polysemy-time = hackage "0.1.2.1" "09l8r5fx0vnapdn8p0cwiwprgg3i67m58dd4j5hcdhw34gfqnnsr";
    };

    main = { hackage, ... }: {
      path = hackage "0.8.0" "0isldidz2gypw2pz399g6rn77x9mppd1mvj5h6ify4pj4mpla0pb";
      relude = hackage "1.0.0.1" "164p21334c3pyfzs839cv90438naxq9pmpyvy87113mwy51gm6xn";
      servant = hackage "0.18.2" "0l2k895nxvw2ngr9201g3br6s9zab7mk5mhpjibyg8mxfbv75a8y";
      servant-client = hackage "0.18.2" "0yip2s63ivrlrpficdipq60j2a6czg8agn18lpkkaxf3n55j4jr3";
      servant-client-core = hackage "0.18.2" "1hazxk1laklpm2c65zgkk2gn8mvlp682437071s04bqggk9b59sx";
      servant-server = hackage "0.18.2" "1kynxl7qg5z45bhi0k61sxn79xkgnq1z97ccqqs39wjyf45fj5yy";
      tasty-hedgehog = hackage "1.1.0.0" "0cs96s7z5csrlwj334v8zl459j5s4ws6gmjh59cv01wwvvrrjwd9";
    };

    compat = { hackage, only, ... }: {
      hspec-wai = only "865" (hackage "0.9.2" "0m179c1kxxgsy3i642ahz5xa4mkrhshqpy8j5wmzrkwbva6zvsgn");
    };
  in
  hix.flake {
    base = ./.;
    compiler = "ghc8104";
    packages.polysemy-http = "packages/polysemy-http";
    overrides = [common main];
    compatOverrides = [common compat];
    ghci.extraArgs = ["-fplugin=Polysemy.Plugin"];
    versionFile = "ops/hpack/packages/polysemy-http.yaml";
  };
}
