{
  description = "Polysemy Effect for Http-Client";

  inputs.hix.url = github:tek/hix;

  outputs = { hix, ... }:
  let

    all = { hackage, unbreak, ... }: {
      exon = hackage "0.2.0.1" "0hs0xrh1v64l1n4zqx3rqfjdh6czxm7av85kj1awya9zxcfcy5cl";
      flatparse = unbreak;
      polysemy = hackage "1.6.0.0" "15k51ysrfcbkww1562g8zvrlzymlk2rxhcsz9ipsb0q6h571qgvf";
      polysemy-conc = hackage "0.5.1.1" "1gqyskqkdavbzpqvlhxf3f5j130w06wc7cw8kxn2cayavzd9zl9b";
      polysemy-plugin = hackage "0.4.0.0" "0pah1a8h8ckbv2fq20hrikrd1p5a3bdxr03npkyixc6mv5k1rmck";
    };

    ghc901 = { hackage, ... }: {
      relude = hackage "1.0.0.1" "164p21334c3pyfzs839cv90438naxq9pmpyvy87113mwy51gm6xn";
    };

    ghc884 = { hackage, ... }: {
      polysemy-test = hackage "0.3.1.7" "0j33f5zh6gyhl86w8kqh6nm02915b4n32xikxc4hwcy7p5l7cl34";
      polysemy-log = hackage "0.3.0.1" "0xjz5wqashhyr2didmdxg69mbk6jgmq6wwgj7w82mj8bdwdvbkm0";
      polysemy-resume = hackage "0.2.0.0" "0kh7cwqkr5w69zkm68l6q4d8nkai7fc29n48p3f8skqw638x4w9p";
      polysemy-time = hackage "0.1.4.0" "0hwx89cilmsdjs3gb5w6by87ysy24scgj5zg77vbfnqpzr3ifrwh";
    };

  in
  hix.flake {
    base = ./.;
    packages.polysemy-http = ./packages/polysemy-http;
    overrides = { inherit all ghc901 ghc884; };
    ghci.extraArgs = ["-fplugin=Polysemy.Plugin"];
    versionFile = "ops/hpack/packages/polysemy-http.yaml";
    ghcid.easy-hls = false;
  };
}
