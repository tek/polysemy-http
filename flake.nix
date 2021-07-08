{
  description = "Polysemy Effect for Http-Client";

  inputs = {
    hix.url = github:tek/hix;
    polysemy.url = github:polysemy-research/polysemy;
  };

  outputs = { hix, polysemy, ... }:
  let
    compat901 = { hackage, source, jailbreak, minimal, noHpack, ... }: {
      cryptonite = hackage "0.29" "1zkw80a6iw8ih33355cfffbyg2md1cn7pcpwnnvr34p0xsykxdrl";
      memory = hackage "0.16.0" "0ix5zdq3c51k959y2n4dfka4dnfjp710c6bms0pk3vhzhxl3q1nh";
      http-client = hackage "0.7.8" "16xil9wdx82wxk7h1ilk0xyb1bkq51rpvvvr1c61j4nkc8v4878v";
      path = hackage "0.9.0" "14symzl1rszvk5zivv85k79anz7xyl5gaxy0sm4vhhzsgxc59msv";
      path-io = jailbreak (hackage "1.6.3" "05hcxgyf6kkz36mazd0fqwb6mjy2049gx3vh8qq9h93gfjkpp2vc");
      polysemy = noHpack (minimal (source.root polysemy));
      polysemy-plugin = noHpack (minimal (source.sub polysemy "polysemy-plugin"));
      relude = hackage "1.0.0.1" "164p21334c3pyfzs839cv90438naxq9pmpyvy87113mwy51gm6xn";
      retry = hackage "0.9.0.0" "09z9vdn656kmkd593m13791v7y75w51ggwv51aw73lilbpas2ba0";
      type-errors-pretty = jailbreak;
      typerep-map = jailbreak (hackage "0.3.3.0" "15i0h2xczf4x898vjd4vgbb8n10gbsbvy2s2pfw4b3vzf0a1rayl");
      servant = hackage "0.18.3" "0dklk3i3bcg85rzrmiggkypkw7pwkh6m5dlrjipsw0njfmlhqfz6";
      servant-client = hackage "0.18.3" "1gz2a0h9xnc1hmfp5bv84pg7vi45b9rvjk1fgy51zizg8vdlagvg";
      servant-client-core = hackage "0.18.3" "1x0f3kalzrwj2blgsmk269m37bb7sygw6lr7dbp0rk6jbrfrkjm1";
      servant-server = hackage "0.18.3" "0388v7drjj0gph99kszxivi4qijbckys67bkbv6384g2zrdplvj7";
      mono-traversable = minimal (hackage "1.0.15.1" "10rbsnawplg501sj6b4366dxah8lsfpi39scg78b1rxbhh7cwqcr");
    };

    common = { hackage, ... }: {
      polysemy = hackage "1.5.0.0" "1xl472xqdxnp4ysyqnackpfn6wbx03rlgwmy9907bklrh557il6d";
      polysemy-conc = hackage "0.1.0.2" "0ijz5l8q53d1s7i100gvjdhzv80dpd140m7a9hyam113ybglc8lg";
      polysemy-plugin = hackage "0.3.0.0" "1frz0iksmg8bpm7ybnpz9h75hp6hajd20vpdvmi04aspklmr6hj0";
      polysemy-log = hackage "0.2.2.1" "1c8kn28a5j9k52jfg5n6nb4ywd76mgrgaqwmf1q0km2kgdi9y40s";
      polysemy-test = hackage "0.3.1.5" "0b8czkn1z27053zw176j6hrpdaw8g31g701v5fp0005wqlngn08x";
      polysemy-time = hackage "0.1.2.4" "17k2rh488pm0gq7y590v3q7vj6qnbf00slwy6pbz5j84a2ql2p8p";
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
  in
  hix.flake {
    base = ./.;
    packages.polysemy-http = ./packages/polysemy-http;
    overrides = [common main];
    compatOverrides = { all = common; ghc901 = compat901; };
    ghci.extraArgs = ["-fplugin=Polysemy.Plugin"];
    versionFile = "ops/hpack/packages/polysemy-http.yaml";
  };
}
