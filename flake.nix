{
  description = "Polysemy Effect for Http-Client";

  inputs.hix.url = github:tek/hix;

  outputs = { hix, ... }:
  let
    common = { hackage, jailbreak, ... }: {
      path = hackage "0.9.0" "14symzl1rszvk5zivv85k79anz7xyl5gaxy0sm4vhhzsgxc59msv";
      path-io = jailbreak (hackage "1.6.3" "05hcxgyf6kkz36mazd0fqwb6mjy2049gx3vh8qq9h93gfjkpp2vc");
      polysemy = hackage "1.6.0.0" "15k51ysrfcbkww1562g8zvrlzymlk2rxhcsz9ipsb0q6h571qgvf";
      polysemy-plugin = hackage "0.4.0.0" "0pah1a8h8ckbv2fq20hrikrd1p5a3bdxr03npkyixc6mv5k1rmck";
      relude = hackage "1.0.0.1" "164p21334c3pyfzs839cv90438naxq9pmpyvy87113mwy51gm6xn";
      servant = hackage "0.18.3" "0dklk3i3bcg85rzrmiggkypkw7pwkh6m5dlrjipsw0njfmlhqfz6";
      servant-client = hackage "0.18.3" "1gz2a0h9xnc1hmfp5bv84pg7vi45b9rvjk1fgy51zizg8vdlagvg";
      servant-client-core = hackage "0.18.3" "1x0f3kalzrwj2blgsmk269m37bb7sygw6lr7dbp0rk6jbrfrkjm1";
      servant-server = hackage "0.18.3" "0388v7drjj0gph99kszxivi4qijbckys67bkbv6384g2zrdplvj7";
    };

    compat901 = { hackage, jailbreak, minimal, ... }: {
      cryptonite = hackage "0.29" "1zkw80a6iw8ih33355cfffbyg2md1cn7pcpwnnvr34p0xsykxdrl";
      memory = hackage "0.16.0" "0ix5zdq3c51k959y2n4dfka4dnfjp710c6bms0pk3vhzhxl3q1nh";
      http-client = hackage "0.7.8" "16xil9wdx82wxk7h1ilk0xyb1bkq51rpvvvr1c61j4nkc8v4878v";
      retry = hackage "0.9.0.0" "09z9vdn656kmkd593m13791v7y75w51ggwv51aw73lilbpas2ba0";
      type-errors-pretty = jailbreak;
      typerep-map = jailbreak (hackage "0.3.3.0" "15i0h2xczf4x898vjd4vgbb8n10gbsbvy2s2pfw4b3vzf0a1rayl");
      mono-traversable = minimal (hackage "1.0.15.1" "10rbsnawplg501sj6b4366dxah8lsfpi39scg78b1rxbhh7cwqcr");
    };

    compat = { hackage, ... }: {
      polysemy = hackage "1.5.0.0" "1xl472xqdxnp4ysyqnackpfn6wbx03rlgwmy9907bklrh557il6d";
      polysemy-conc = hackage "0.1.0.3" "0g4z20il8l2hgg2m6vmc6mk6c1x7rml57q4fg9gnri06vavsxy5n";
      polysemy-plugin = hackage "0.3.0.0" "1frz0iksmg8bpm7ybnpz9h75hp6hajd20vpdvmi04aspklmr6hj0";
      polysemy-log = hackage "0.2.2.2" "0dmsyi970ddl3ihvm51cbdmlhnkl2c7lkjhwxgbk8ilf1hhd1r72";
      polysemy-test = hackage "0.3.1.6" "0bfh37l68a5chhjfr7gqcffsmvdgg5hqclxi0fc5xnqni2mg81ak";
      polysemy-time = hackage "0.1.3.1" "1ldg92dmy1nyjhkbmh5k32q94pn2c7qcfjc4yhl4lc1wnfp6r59m";
    };

    main = { hackage, ... }: {
      tasty-hedgehog = hackage "1.1.0.0" "0cs96s7z5csrlwj334v8zl459j5s4ws6gmjh59cv01wwvvrrjwd9";
    };
  in
  hix.flake {
    base = ./.;
    packages.polysemy-http = ./packages/polysemy-http;
    overrides = [compat common main];
    compatOverrides = { all = compat; ghc901 = [common compat901]; };
    ghci.extraArgs = ["-fplugin=Polysemy.Plugin"];
    versionFile = "ops/hpack/packages/polysemy-http.yaml";
  };
}
