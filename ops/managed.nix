{
  bounds = {
    polysemy-http = {
      aeson = {
        lower = "2.1.0.0";
        upper = "2.3";
      };
      base = {
        lower = "4.17.2.1";
        upper = "4.21";
      };
      case-insensitive = {
        lower = "1.2.0.11";
        upper = "1.3";
      };
      exon = {
        lower = "1.4.0.0";
        upper = "1.8";
      };
      hedgehog = {
        lower = "1.1.2";
        upper = "1.8";
      };
      http-client = {
        lower = "0.5.13.1";
        upper = "0.8";
      };
      http-client-tls = {
        lower = "0.3.0";
        upper = "0.4";
      };
      http-types = {
        lower = "0.12.3";
        upper = "0.13";
      };
      network = {
        lower = "3.1.2.9";
        upper = "3.3";
      };
      polysemy = {
        lower = "1.9.0.0";
        upper = "1.10";
      };
      polysemy-http = {
        lower = null;
        upper = null;
      };
      polysemy-plugin = {
        lower = "0.4.4.0";
        upper = "0.5";
      };
      prelate = {
        lower = "0.5.0.0";
        upper = "0.9";
      };
      servant = {
        lower = "0.19.1";
        upper = "0.21";
      };
      servant-client = {
        lower = "0.19";
        upper = "0.21";
      };
      servant-server = {
        lower = "0.19.2";
        upper = "0.21";
      };
      tasty = {
        lower = "1.2.2";
        upper = "1.6";
      };
      tasty-hedgehog = {
        lower = "1.3.0.0";
        upper = "1.5";
      };
      time = {
        lower = "1.12.2";
        upper = "1.13";
      };
      warp = {
        lower = "3.3.21";
        upper = "3.5";
      };
    };
  };
  versions = {
    latest = {
      aeson = "2.2.3.0";
      base = "4.20.0.0";
      case-insensitive = "1.2.1.0";
      exon = "1.7.2.0";
      hedgehog = "1.7";
      http-client = "0.7.19";
      http-client-tls = "0.3.6.4";
      http-types = "0.12.4";
      network = "3.2.8.0";
      polysemy = "1.9.2.0";
      polysemy-plugin = "0.4.5.3";
      prelate = "0.8.0.0";
      servant = "0.20.3.0";
      servant-client = "0.20.3.0";
      servant-server = "0.20.3.0";
      tasty = "1.5.3";
      tasty-hedgehog = "1.4.0.2";
      time = "1.12.2";
      warp = "3.4.11";
    };
    lower = {
      aeson = "2.1.0.0";
      base = "4.17.2.1";
      case-insensitive = "1.2.0.11";
      exon = "1.4.0.0";
      hedgehog = "1.1.2";
      http-client = "0.5.13.1";
      http-client-tls = "0.3.0";
      http-types = "0.12.3";
      network = "3.1.2.9";
      polysemy = "1.9.0.0";
      polysemy-plugin = "0.4.4.0";
      prelate = "0.5.0.0";
      servant = "0.19.1";
      servant-client = "0.19";
      servant-server = "0.19.2";
      tasty = "1.2.2";
      tasty-hedgehog = "1.3.0.0";
      time = "1.12.2";
      warp = "3.3.21";
    };
  };
  initial = {
    latest = {};
    lower = {
      aeson = "2.1.0.0";
      case-insensitive = "1.2.0.11";
      exon = "1.7.0.0";
      hedgehog = "1.2";
      http-client = "0.7.0";
      http-client-tls = "0.3.0";
      http-types = "0.12.3";
      network = "3.1.2.9";
      polysemy = "1.9.0.0";
      polysemy-plugin = "0.4.4.0";
      prelate = "0.8.0.0";
      servant = "0.20";
      servant-client = "0.20";
      servant-server = "0.20";
      tasty = "1.4";
      tasty-hedgehog = "1.4.0.0";
      time = "1.12.2";
      warp = "3.4.0";
    };
  };
  overrides = {
    latest = {
      base16-bytestring = {
        version = "1.0.2.0";
        hash = "0r3p5q5zxcrk5cbnwdcm435pgx3yjv3slidpjxdsvigdxizq4fyv";
        repo = "hackage.haskell.org";
      };
      bytebuild = {
        version = "0.3.16.2";
        hash = "0r14dmwywpr91qrnck3lb269hn8nmfmfwww11yglggn6fmjv6ks7";
        repo = "hackage.haskell.org";
        revision = true;
      };
      cabal-doctest = {
        version = "1.0.11";
        hash = "152rqpicqpvigjpy4rf1kjlwny1c7ys1r0r123wdjafvv1igflii";
        repo = "hackage.haskell.org";
      };
      cborg = {
        version = "0.2.10.0";
        hash = "01brd08j3vr163l3v9cg1yq3sr4m5nfdadgg7dc3i2ksmfyj60bl";
        repo = "hackage.haskell.org";
      };
      chronos = {
        version = "1.1.6.1";
        hash = "037h68ji0f362irn9n9qwvr7d1ff6inpbc8d5wa4d63223713k9m";
        repo = "hackage.haskell.org";
        revision = true;
      };
      crypton-connection = {
        version = "0.4.5";
        hash = "1l5yr5nck4vyi55pyc7j1zarfcs196gbxjlwljs7s7v2r3h43jcc";
        repo = "hackage.haskell.org";
      };
      crypton-socks = {
        version = "0.6.2";
        hash = "1cbshd13dmc0092cani21hqyi3w22whvxah94yqsy4nqwmyihvlv";
        repo = "hackage.haskell.org";
      };
      exon = {
        version = "1.7.2.0";
        hash = "0hg271cvjqm4ps75qpnirq9nvjwpwb03mcbn1a364jrysrj6bg3b";
        repo = "hackage.haskell.org";
      };
      fast-logger = {
        version = "3.2.5";
        hash = "0872c6clb0p7js9g3p8xn2xfr97d0zqi8rp8zlxl5hpy5q32jlli";
        repo = "hackage.haskell.org";
      };
      generics-sop = {
        version = "0.5.1.4";
        hash = "0ai089kly1cajn4djqnplkg2jmnapqlb3crrsyvfnadcyzc9h3km";
        repo = "hackage.haskell.org";
      };
      half = {
        version = "0.3.3";
        hash = "1g2ps399367z24bsikrzjvvrz2di7z29sk5micz2ypvhx6fis0zp";
        repo = "hackage.haskell.org";
      };
      hedgehog = {
        version = "1.7";
        hash = "04cjnz4i1qs3v9bza8a3ry1czapwqgxazhywkjzq2rg1544gjmby";
        repo = "hackage.haskell.org";
      };
      hsc2hs = {
        version = "0.68.10";
        hash = "0wdg17kicnp6qbgynha216vihx7nnsglvhn5c089dqpa14hg35zw";
        repo = "hackage.haskell.org";
      };
      http-client = {
        version = "0.7.19";
        hash = "1qciglcaik1a96flj07fhqx2h692kgcv63hinffr35ka22wrg3i9";
        repo = "hackage.haskell.org";
      };
      http-client-tls = {
        version = "0.3.6.4";
        hash = "1f8br94l5kywpsfvpmw54b1v6nx1yapslzrwiswsf6vf8kwfjjzg";
        repo = "hackage.haskell.org";
      };
      http-semantics = {
        version = "0.4.0";
        hash = "0p9qb38z9khk91cy78lv8f66693xyxn9yy87mnwwpghaa7kk67df";
        repo = "hackage.haskell.org";
      };
      http2 = {
        version = "5.4.0";
        hash = "1wa88jb5hk64g4v320jsj4sfldcpwkjjvpxvxh30yvdmvraidq9x";
        repo = "hackage.haskell.org";
      };
      incipit = {
        version = "0.10.0.0";
        hash = "1r3y2wp8wz1ii28a6wb76z6w3sgiah158kwsadrr13w6iryhq047";
        repo = "hackage.haskell.org";
        revision = true;
      };
      incipit-base = {
        version = "0.5.1.0";
        hash = "0hkqnqpdw8rvg4xzslw9sp3684ggyk9n4hr0lczwm8b0pzakzs0l";
        repo = "hackage.haskell.org";
        revision = true;
      };
      incipit-core = {
        version = "0.5.1.0";
        hash = "04lyzycvqxyjqcd703cd33lnlk5va9wj3czpsybah0ybydnrwabd";
        repo = "hackage.haskell.org";
        revision = true;
      };
      iproute = {
        version = "1.7.15";
        hash = "1a6kjmm0kqqalyc8qbaa6pwnz7nlclfphqmnxxq8f4yhaa4xd19j";
        repo = "hackage.haskell.org";
      };
      network = {
        version = "3.2.8.0";
        hash = "0zynf3wgy6x5ak5i1a6wv52v64aqzvaq33wsrm37j1q3ana6xmw7";
        repo = "hackage.haskell.org";
      };
      polysemy-chronos = {
        version = "0.7.0.0";
        hash = "0srq4xda9rracrf0frqh9vb00fscxyjv8w6fgavgxbxsrir856i8";
        repo = "hackage.haskell.org";
      };
      polysemy-conc = {
        version = "0.14.1.0";
        hash = "0lzgw6dqhw0dv00bn9aasys2v8iddxyck5vmpglrp92chba55jxv";
        repo = "hackage.haskell.org";
        revision = true;
      };
      polysemy-log = {
        version = "0.11.0.0";
        hash = "1phzwj2ig0vx1anscg3qv53ysa0f7gks37pc8gfkh2aws3qp6cda";
        repo = "hackage.haskell.org";
        revision = true;
      };
      polysemy-plugin = {
        version = "0.4.5.3";
        hash = "1c2agk21jj7fwdj6xkagq0prvxknp3zr6q1f480wizssibcvm7y6";
        repo = "hackage.haskell.org";
      };
      polysemy-process = {
        version = "0.14.1.0";
        hash = "125fiwq30ybncmc0pb25ki3k2sxbhkjz4k2i53bcj9y026xgvjyi";
        repo = "hackage.haskell.org";
        revision = true;
      };
      polysemy-resume = {
        version = "0.9.0.0";
        hash = "1achlwdkycbgjlcdkq641r481m1bl9rb7fklbwfb9nnb6xmqyzms";
        repo = "hackage.haskell.org";
        revision = true;
      };
      polysemy-test = {
        version = "0.10.0.1";
        hash = "1sp9iag1brknmdy0qvmgnmynwc4gbg1jy21w584x1m2hpqi25p6j";
        repo = "hackage.haskell.org";
      };
      polysemy-time = {
        version = "0.7.0.0";
        hash = "0imvjiybxrsggh72pfkd226pvzhz5hg1zvxyd72b91a3xz1vynmq";
        repo = "hackage.haskell.org";
        revision = true;
      };
      prelate = {
        version = "0.8.0.0";
        hash = "0id72rbynmbb15ld8pv8nijll3k50x2mrpcqsv8dkbs7q05fn9vg";
        repo = "hackage.haskell.org";
      };
      recv = {
        version = "0.1.1";
        hash = "1hdwkg5isw7aknmjil7fqgbp1y53wgcdndq1aph81zh89xxy33p2";
        repo = "hackage.haskell.org";
      };
      serialise = {
        version = "0.2.6.1";
        hash = "1f1slh4n0l6wdq5dn44zigiglf03i8nw9g33i572hmxarwir0qlq";
        repo = "hackage.haskell.org";
      };
      servant = {
        version = "0.20.3.0";
        hash = "0vgppwv8fzfi1wc7n72lqrj49xfn8ymjh1balpsphhj4bc7n6lvi";
        repo = "hackage.haskell.org";
      };
      servant-client = {
        version = "0.20.3.0";
        hash = "0xlf354mcvg3cg8nqfi1aqfym686qcyy1yv46fg9fxchms9njczr";
        repo = "hackage.haskell.org";
      };
      servant-client-core = {
        version = "0.20.3.0";
        hash = "0yv0asv77zjclnvadjb2hxjghnmz5rnba4akg237x3ssh50i52ca";
        repo = "hackage.haskell.org";
      };
      servant-server = {
        version = "0.20.3.0";
        hash = "053d5j5sxki31v8d5b73jx53bfhz76pm8xyb99n0rk1gxc8rg18x";
        repo = "hackage.haskell.org";
      };
      simple-sendfile = {
        version = "0.2.32";
        hash = "0pwkrx671knwly65najq72jqg7h6nfkmf215jrb8bp8jj4g2vd14";
        repo = "hackage.haskell.org";
      };
      streaming-commons = {
        version = "0.2.3.0";
        hash = "13adg89zx9qzirw9ibmz70qnbwgnhmzjkbp4fh6l6qskfh1fyysm";
        repo = "hackage.haskell.org";
      };
      tasty = {
        version = "1.5.3";
        hash = "1xjlmgsww34asjl9rcwbziw5l4qqbvi5l4b7qvzf4dc7hqkpq1rs";
        repo = "hackage.haskell.org";
      };
      tasty-hedgehog = {
        version = "1.4.0.2";
        hash = "04kg2qdnsqzzmj3xggy2jcgidlp21lsjkz4sfnbq7b1yhrv2vbbc";
        repo = "hackage.haskell.org";
      };
      time-manager = {
        version = "0.2.4";
        hash = "176y8svag2fbmvicxgxkhv36gbaak2id3zbwaf40sbaqgpgpy2xh";
        repo = "hackage.haskell.org";
      };
      tls = {
        version = "2.1.6";
        hash = "11rxsmwhv6g4298a0355v6flz4n6gw64qw3iha7z0ka3nv7vq4vv";
        repo = "hackage.haskell.org";
      };
      wai = {
        version = "3.2.4";
        hash = "1vxagql34hjvnrw0116kx6z5wnj4gcddf36kfs65f6zr2ib6c11l";
        repo = "hackage.haskell.org";
      };
      wai-app-static = {
        version = "3.1.9";
        hash = "1kwvzy9w4v76q5bk4xwq7kz9q9l8867my6zvsv731x6xkhy7wr2c";
        repo = "hackage.haskell.org";
      };
      wai-extra = {
        version = "3.1.17";
        hash = "0lvsv014k2fpd3rm99qkfkh47zic7wg39zgv7g7ll06515ly23w9";
        repo = "hackage.haskell.org";
      };
      wai-logger = {
        version = "2.5.0";
        hash = "1l0gspzbwkrs1dqay2rv5wz1gg49a31l3vyl741b2j2apkgamf3p";
        repo = "hackage.haskell.org";
      };
      warp = {
        version = "3.4.11";
        hash = "197cwr7aky7psm3in7cha5ni6qzmm0ah7qd4hibsr37rpmgw1nlv";
        repo = "hackage.haskell.org";
      };
      wide-word = {
        version = "0.1.6.0";
        hash = "07vgylw2p7sm6iisq8p9gy185v7pl163bz2a4g41a1gasd45cwy1";
        repo = "hackage.haskell.org";
        revision = true;
      };
    };
    lower = {
      OneTuple = {
        version = "0.3.1";
        hash = "0mb81j6zhvzq7h9yyhi9cszrq1g5d4lv3a8wpwimcvzbyg9bdd6p";
        repo = "hackage.haskell.org";
      };
      adjunctions = {
        version = "4.4.3";
        hash = "1k940bpa8qiqrj6hh8jh2vshdfdisi827i3l6m2hwajc4yhjlrgg";
        repo = "hackage.haskell.org";
      };
      aeson = {
        version = "2.1.0.0";
        hash = "08s162yh716aaxd42k1kyv18p9nsyab42ns4340kvs6r0i8riwsi";
        repo = "hackage.haskell.org";
      };
      ansi-terminal = {
        version = "0.11.5";
        hash = "0g7ycc2b67z8plqp7hva914yhwzjmvvhhf9mszlhj3kqxh6i732b";
        repo = "hackage.haskell.org";
      };
      assoc = {
        version = "1.0.2";
        hash = "1sfc21z18sf8rpsbcr77kgw7qjpm5cm1d24n5ifsm2zid88v8fs9";
        repo = "hackage.haskell.org";
      };
      atomic-primops = {
        version = "0.8.8";
        hash = "1razf9zq71am8x1813rrq8m14z6lnrkaacw4zcr5rii6f1q1l6xh";
        repo = "hackage.haskell.org";
      };
      attoparsec = {
        version = "0.14.4";
        hash = "0y9dph5axyvr1bfcvmz6qh50bjcp50m2ljra14960anc6g74a3c8";
        repo = "hackage.haskell.org";
      };
      attoparsec-iso8601 = {
        version = "1.1.0.0";
        hash = "0jjkgma9k55mhjhrc178kh19366x3b4abddvqhsmcrd7wqcvcb40";
        repo = "hackage.haskell.org";
      };
      base-compat = {
        version = "0.12.3";
        hash = "0vnns2imggv0b9gbbd9k0p8hdwlimka50gqbvknwkwbnv3kil7lb";
        repo = "hackage.haskell.org";
      };
      base-compat-batteries = {
        version = "0.12.3";
        hash = "0jg1wki5qbghjd5ra23ldc69jal9jjwrwp6wz8gg4gcrjlxbwg7m";
        repo = "hackage.haskell.org";
      };
      bifunctors = {
        version = "5.5.15";
        hash = "0qymwahcn7nqw3n9hvgh0nqhpm6p2ci1grmnwwfplvhxsaka91aj";
        repo = "hackage.haskell.org";
      };
      bytebuild = {
        version = "0.3.16.3";
        hash = "1qka0dr6g534vi8p3iwlshdi1iklhgaajg9fbbzvkg49pzj1sak7";
        repo = "hackage.haskell.org";
      };
      byteslice = {
        version = "0.2.14.0";
        hash = "1ih3g6zcdnlk3y3z4h083jncydai8c0gs240dxih3wwi0d1n2vm9";
        repo = "hackage.haskell.org";
      };
      bytesmith = {
        version = "0.3.11.1";
        hash = "0pkmxlww2g20lfq22s5n332ff9mh0a5qjmlvvi4bh8mbf6r2jc1m";
        repo = "hackage.haskell.org";
      };
      cabal-doctest = {
        version = "1.0.11";
        hash = "152rqpicqpvigjpy4rf1kjlwny1c7ys1r0r123wdjafvv1igflii";
        repo = "hackage.haskell.org";
      };
      case-insensitive = {
        version = "1.2.0.11";
        hash = "0nn4hffa6i3sf6n1cg69br7qiwsc3shw26ay9bkwhkff6lfpw1bj";
        repo = "hackage.haskell.org";
      };
      chronos = {
        version = "1.1.6.2";
        hash = "1pbfp25py682d17visa4i9rjxmiim8aykrgs7nv2q9anajv88kdx";
        repo = "hackage.haskell.org";
      };
      concurrent-output = {
        version = "1.10.21";
        hash = "1w87rrf337s8wc4z3dkh2mk990003jsk18ry5yawv4465k4yvamw";
        repo = "hackage.haskell.org";
      };
      connection = {
        version = "0.3.1";
        hash = "0qjdz2fxxszbns7cszhnkwm8x8l3xlnad6iydx2snfi416sypiy0";
        repo = "hackage.haskell.org";
      };
      constraints = {
        version = "0.13.4";
        hash = "0lzg6adirmig37246cpbak6rk459kdfi312kc0rpcapk660zp9ws";
        repo = "hackage.haskell.org";
      };
      contiguous = {
        version = "0.6.4.2";
        hash = "1vkqnggzniw24241lrmww7bmpprcpn12z5rrskxpq33wmad3wvsz";
        repo = "hackage.haskell.org";
      };
      cryptonite = {
        version = "0.30";
        hash = "04wq8lh300dng87n59a37ngjqbwjlxpd62vz6ifvz0gpyx0pnhy7";
        repo = "hackage.haskell.org";
      };
      exon = {
        version = "1.4.0.0";
        hash = "1m4i3a14wip985ncblfy2ikcy7gw5rryj9z497ah218d1nmwj7rl";
        repo = "hackage.haskell.org";
      };
      flatparse = {
        version = "0.4.1.0";
        hash = "0z9q5qb3yz4phvj1wq06dld745m98yk4gvkmj1vkq7hda0mn182a";
        repo = "hackage.haskell.org";
      };
      free = {
        version = "5.1.10";
        hash = "1s67yl7wnrxnljmpyihwlaj40h3rayymd9nqx9z0s05nlga2xsll";
        repo = "hackage.haskell.org";
      };
      generic-lens = {
        version = "2.2.2.0";
        hash = "08z7x2vylam9v5f4z62k3qs7phdzlks6a5g0nn2w5cczqpg6ybjd";
        repo = "hackage.haskell.org";
      };
      generics-sop = {
        version = "0.5.1.3";
        hash = "1xj700x702xwggfd6dg2wya1gnnsb1p32nzi00f1am49xjy2alh1";
        repo = "hackage.haskell.org";
      };
      ghc-hs-meta = {
        version = "0.1.5.0";
        hash = "19z2704dl6x4lkgfaynhn550wdghpj9qdwh5xr96drp3nkh012dl";
        repo = "hackage.haskell.org";
      };
      haskell-src-meta = {
        version = "0.8.15";
        hash = "0ccwgfkb1n31wwfysdhc1mqpcnnxnczwmz3d4avm9yn9a5m1nh4s";
        repo = "hackage.haskell.org";
      };
      hedgehog = {
        version = "1.1.2";
        hash = "0zp9al4d4h3vf2h7cqf6zmvzpmjr7w69kcp7fmw97m9c7h7ggniv";
        repo = "hackage.haskell.org";
      };
      hsc2hs = {
        version = "0.68.10";
        hash = "0wdg17kicnp6qbgynha216vihx7nnsglvhn5c089dqpa14hg35zw";
        repo = "hackage.haskell.org";
      };
      http-api-data = {
        version = "0.5";
        hash = "1ibh9zlj4s7q5wfryfj2b83kipl8fnvfli74p8293304prsj0hkz";
        repo = "hackage.haskell.org";
      };
      http-client = {
        version = "0.5.13.1";
        hash = "0xrs5l0n8jw4v7ckw5gvv7ijdwd0c1jl0196n5x84nhnx7jbqj7c";
        repo = "hackage.haskell.org";
      };
      http-client-tls = {
        version = "0.3.0";
        hash = "08rwd8xmiq4ppxfzid9x01vr9b5sq7zbzc7kad1gashh4ybfd921";
        repo = "hackage.haskell.org";
      };
      http-date = {
        version = "0.0.11";
        hash = "1f3hq5s6q54r4sv68h9fpafw9z52x2iqc6bwqkjw11v9d1x13mh1";
        repo = "hackage.haskell.org";
      };
      http-media = {
        version = "0.8.1.1";
        hash = "10rxh1brpi9gsjrhgf5227z1gxrliipmiagp6j300jdgpf3rk8f3";
        repo = "hackage.haskell.org";
      };
      http-types = {
        version = "0.12.3";
        hash = "0239y1r25n7wnnf2ci5lajj0rf35j2ywa07f9lpccnry13zbh8dv";
        repo = "hackage.haskell.org";
      };
      http2 = {
        version = "3.0.3";
        hash = "150511gq5cljkdrvkxxb4cw3yrs530p9p3nzgbip3bzrqjfm2b9k";
        repo = "hackage.haskell.org";
      };
      incipit = {
        version = "0.7.0.0";
        hash = "1gwca88qldfn7qmx0wmpcpasr8qajyppijj8ahif8lav3pf37gvn";
        repo = "hackage.haskell.org";
      };
      incipit-core = {
        version = "0.5.1.0";
        hash = "04lyzycvqxyjqcd703cd33lnlk5va9wj3czpsybah0ybydnrwabd";
        repo = "hackage.haskell.org";
      };
      indexed-traversable-instances = {
        version = "0.1.2";
        hash = "05vpkasz70yjf09hsmbw7nap70sr8p5b7hrsdbmij8k8xqf3qg8r";
        repo = "hackage.haskell.org";
      };
      invariant = {
        version = "0.6.3";
        hash = "1dl7jslb3y4csj1s01b7q0i175ad9mgira39gv7f1jv72cnnrp5a";
        repo = "hackage.haskell.org";
      };
      iproute = {
        version = "1.7.15";
        hash = "1a6kjmm0kqqalyc8qbaa6pwnz7nlclfphqmnxxq8f4yhaa4xd19j";
        repo = "hackage.haskell.org";
      };
      kan-extensions = {
        version = "5.2.6";
        hash = "1yl3w6a99k56qk72wnlxmd61j9k00i8rvjx8h7cgdi60ib2w7a7k";
        repo = "hackage.haskell.org";
      };
      lifted-async = {
        version = "0.10.2.7";
        hash = "0cgzs8sfr3l7ah5nnscpp50v5mmvc4hqf02zdi4h344dbbha10fy";
        repo = "hackage.haskell.org";
      };
      network = {
        version = "3.1.2.9";
        hash = "0cqiv0fjsa6yi1kqal6q290bx5nakp4yayq98b6p6rmmgzv96xfy";
        repo = "hackage.haskell.org";
      };
      optparse-applicative = {
        version = "0.18.1.0";
        hash = "0wggvi67lm2amw0igmpfqs75jvy91zv42v33c12vmk9fdqkwalmg";
        repo = "hackage.haskell.org";
      };
      path = {
        version = "0.9.5";
        hash = "05b84rizmrii847pq2fbvlpna796bwxha1vc01c3vxb2rhrknrf7";
        repo = "hackage.haskell.org";
      };
      path-io = {
        version = "1.7.0";
        hash = "03gpa5x3fbn79bs18bl9nm394slrhc8cd2cydwca8l7yldcmy1i9";
        repo = "hackage.haskell.org";
      };
      polysemy = {
        version = "1.9.0.0";
        hash = "1af07cppnjpv5v56wanya1mhkvbfnyynf5447mnkcf4zc4k23pyk";
        repo = "hackage.haskell.org";
      };
      polysemy-chronos = {
        version = "0.6.0.2";
        hash = "1wvjpl2axxhywjj7z1hjg16sxldq0x63md4rzf1mvdn8067mg35s";
        repo = "hackage.haskell.org";
      };
      polysemy-conc = {
        version = "0.12.1.0";
        hash = "0cm2hkr58fhxr2w5pmq01m66qmd1yfzikjx5v7c0xsk8mdjv9f6g";
        repo = "hackage.haskell.org";
      };
      polysemy-log = {
        version = "0.9.0.0";
        hash = "0ymgd7lzlgzwi895l4p754qwdy72c1g13b8drn5a970ym7zcklpg";
        repo = "hackage.haskell.org";
      };
      polysemy-plugin = {
        version = "0.4.4.0";
        hash = "08ry72bw78fis9iallzw6wsrzxnlmayq2k2yy0j79hpw4sp8knmg";
        repo = "hackage.haskell.org";
      };
      polysemy-process = {
        version = "0.12.1.0";
        hash = "17hs8grh5ppbdf2vp63flwb0kahyp776jqh4c6c1amwfja4b2avc";
        repo = "hackage.haskell.org";
      };
      polysemy-resume = {
        version = "0.7.0.0";
        hash = "1b9agh2qd0nrbd7cc5iabkzjb7g9lnzzy3pprvn33hr54va9p928";
        repo = "hackage.haskell.org";
      };
      polysemy-time = {
        version = "0.6.0.2";
        hash = "198x2wimdzk93hz0bq2k7wjibcjvzm38m6fica1jfcbh4p531swp";
        repo = "hackage.haskell.org";
      };
      prelate = {
        version = "0.5.0.0";
        hash = "0zs75i3ij4a82aqk4i324nrn5g3vclkspgrd8qdm9jj73pvq8za5";
        repo = "hackage.haskell.org";
      };
      prettyprinter-ansi-terminal = {
        version = "1.1.3";
        hash = "09m8knzfvms12576pp2nrdn7j0wikylwjfr9r3z4swgipz1r3nki";
        repo = "hackage.haskell.org";
      };
      primitive = {
        version = "0.7.4.0";
        hash = "0n7r8al9wgz4r7jzizapn1dbnkqxwx2c4lqkgfm5q5bxj8fl7g1c";
        repo = "hackage.haskell.org";
      };
      primitive-addr = {
        version = "0.1.0.3";
        hash = "0b01fgjlh380sax6n20sjlw8lfalirhjxaf1iv2qgifzv2sc0xwk";
        repo = "hackage.haskell.org";
      };
      primitive-offset = {
        version = "0.2.0.1";
        hash = "0c5rvyfbh3ly6p38p5cnikh6a0is7gn7fj0ddn168c8df1cqalw5";
        repo = "hackage.haskell.org";
      };
      primitive-unlifted = {
        version = "2.2.0.0";
        hash = "1z4nh2pv9ylbc9mw9dfmjschyn6ci0rqhz5nn9mld3wz45a15aq5";
        repo = "hackage.haskell.org";
      };
      profunctors = {
        version = "5.6.2";
        hash = "19gnn2br16x52lmvfjj06xblsks0wz3081z0jf0jydncbgm6kfan";
        repo = "hackage.haskell.org";
      };
      resourcet = {
        version = "1.2.6";
        hash = "0k96r6mx6zf0nr5y7xjzyhizx80svjfa3a47hcyys10y08rgqvln";
        repo = "hackage.haskell.org";
      };
      run-st = {
        version = "0.1.3.3";
        hash = "1x5brxdbncfgzvdl8k6h00zpzzv319j7iw3k5lgrimhdm0jz2vz7";
        repo = "hackage.haskell.org";
      };
      scientific = {
        version = "0.3.7.0";
        hash = "09iwj0snmx7vj7x03l4vdcn76zylcgxd9pyz0yxkydgfnn3lvc08";
        repo = "hackage.haskell.org";
      };
      semialign = {
        version = "1.2.0.1";
        hash = "0mpw54c3s0x70k5l52a57yhnmbgrksb3dn0vjq4m37spyzsfl1v2";
        repo = "hackage.haskell.org";
      };
      semigroupoids = {
        version = "5.3.7";
        hash = "0sknyh441xrna6w6d65j189n59najbp8h7g2ndr9qswxh7z2qaf1";
        repo = "hackage.haskell.org";
      };
      servant = {
        version = "0.19.1";
        hash = "1bb06s6b6wfd3il5jc04h0qlg7w4260kqd05y7jd8x70h1hx8nm7";
        repo = "hackage.haskell.org";
      };
      servant-client = {
        version = "0.19";
        hash = "1l0yjal6piigx7makvg8xgn1gz90fjr8kflsaf8ilkvlfrglfqmz";
        repo = "hackage.haskell.org";
      };
      servant-client-core = {
        version = "0.19";
        hash = "0z20rmavxajq2fv7889x17gym4c7hkllmp5xzmw25c9pcjkq96zx";
        repo = "hackage.haskell.org";
      };
      servant-server = {
        version = "0.19.2";
        hash = "18gb42ym5q34v7ny0xs0mlwf9z4n6jk63fsacw124039b8yami8w";
        repo = "hackage.haskell.org";
      };
      simple-sendfile = {
        version = "0.2.31";
        hash = "0cxxgg46b709lk5302jcipipg0yx0aqlzn5h28a6ds9sk3lx6rsi";
        repo = "hackage.haskell.org";
      };
      singleton-bool = {
        version = "0.1.6";
        hash = "1pycigjhy86c8v6np7hdrp9m5cgzvmyk1gjgvif89pv3s513mww3";
        repo = "hackage.haskell.org";
      };
      socks = {
        version = "0.6.1";
        hash = "0750g9cd22w0hlxcz8hrghlrbgsyja3x994d9m7sq5jh3s52da92";
        repo = "hackage.haskell.org";
      };
      streaming-commons = {
        version = "0.2.3.0";
        hash = "13adg89zx9qzirw9ibmz70qnbwgnhmzjkbp4fh6l6qskfh1fyysm";
        repo = "hackage.haskell.org";
      };
      strict = {
        version = "0.4.0.1";
        hash = "0xhr98m2632k2pic8q9bpnm3mp9098mmg4s66ds052b92494k49f";
        repo = "hackage.haskell.org";
      };
      string-conversions = {
        version = "0.4.0.1";
        hash = "06rfwj2bb8m2by6h2xja69r45rghmil9ali5i89khfh46nnadjpq";
        repo = "hackage.haskell.org";
      };
      tasty = {
        version = "1.2.2";
        hash = "07vyy71nxl7q00akjcghsqd1lz9yf7lfr9kicr2q4ydfj9xkv8bw";
        repo = "hackage.haskell.org";
      };
      tasty-hedgehog = {
        version = "1.3.0.0";
        hash = "17q94i4rwdp1bc2wg5r8pblp8i74ivhc4nqih4w5ncmvhws0syix";
        repo = "hackage.haskell.org";
      };
      text-short = {
        version = "0.1.6";
        hash = "08rwbc2zcvbvswvy0kp14jg2wq08ls6m6grywp0srjipavzx11s3";
        repo = "hackage.haskell.org";
        revision = true;
      };
      th-abstraction = {
        version = "0.4.5.0";
        hash = "19nh7a9b4yif6sijp6xns6xlxcr1mcyrqx3cfbp5bdm7mkbda7a9";
        repo = "hackage.haskell.org";
      };
      th-expand-syns = {
        version = "0.4.12.0";
        hash = "05p82h3hb7ayidc98qq2bgj790d7km9ixp5ijgc1qqkksg3php6z";
        repo = "hackage.haskell.org";
      };
      th-lift = {
        version = "0.8.4";
        hash = "0rp32lkvx22alxc7c1mxgf224jyanfy93ry70zwdn6zzj50mnbhc";
        repo = "hackage.haskell.org";
      };
      th-orphans = {
        version = "0.13.16";
        hash = "1ih88wwgrxmj04awk0693pjhi19grhh33c6ckc0gckvkisp5lyb5";
        repo = "hackage.haskell.org";
      };
      th-reify-many = {
        version = "0.1.10";
        hash = "0g9axz1iszl02cxvy2zgmzinjvz8pbsfq3lzhspshlw5bgcsld39";
        repo = "hackage.haskell.org";
      };
      these = {
        version = "1.1.1.1";
        hash = "1i1nfh41vflvqxi8w8n2s35ymx2z9119dg5zmd2r23ya7vwvaka1";
        repo = "hackage.haskell.org";
      };
      tls = {
        version = "1.6.0";
        hash = "1bw3y5bxxpa3xncvh6g8z8x5gxz8kjl2didk229m7l79jvcicijy";
        repo = "hackage.haskell.org";
      };
      tuples = {
        version = "0.1.0.0";
        hash = "1cn7cjrsigimwmxnw1jm1fvaw5r9k4dia9jwwbc0yx7wc9rj8gyx";
        repo = "hackage.haskell.org";
      };
      type-equality = {
        version = "1.0.1";
        hash = "1447aajfr8hv99zgv8n1f5jblfqb498cnlxz9smrvz4d4rc24mvi";
        repo = "hackage.haskell.org";
      };
      type-errors = {
        version = "0.2.0.2";
        hash = "09rkyqhx8jnzqiq7gpcm5jd1xd435h0ma0b2sff18lk31qv01x6g";
        repo = "hackage.haskell.org";
      };
      unagi-chan = {
        version = "0.4.1.4";
        hash = "1glfzdm732p0zbwq6vg0syw4cg7f72k1982rc6ha8wyr46czdlmm";
        repo = "hackage.haskell.org";
      };
      unbounded-delays = {
        version = "0.1.1.1";
        hash = "1kbh2yr7lwzrhjniyfllsix2zn8bmz9yrkhnq5lxv9ic9bbxnls7";
        repo = "hackage.haskell.org";
      };
      unordered-containers = {
        version = "0.2.20";
        hash = "0dvlf9by7mkwaxg2x26m6bf5bnqr1l07j6adksavvziiq0x3p135";
        repo = "hackage.haskell.org";
        revision = true;
      };
      uuid-types = {
        version = "1.0.5.1";
        hash = "0kf0877vz9zd9vb9ljab2vx010s6rqq5jskbdlw3nc5b25ycsj3f";
        repo = "hackage.haskell.org";
        revision = true;
      };
      vector = {
        version = "0.13.2.0";
        hash = "0mgc7ikhdgqwsj5skdxsf6v3a1iqkiiysqj94qnbg40ff8nbai4x";
        repo = "hackage.haskell.org";
      };
      wai = {
        version = "3.2.4";
        hash = "1vxagql34hjvnrw0116kx6z5wnj4gcddf36kfs65f6zr2ib6c11l";
        repo = "hackage.haskell.org";
      };
      wai-app-static = {
        version = "3.1.9";
        hash = "1kwvzy9w4v76q5bk4xwq7kz9q9l8867my6zvsv731x6xkhy7wr2c";
        repo = "hackage.haskell.org";
      };
      wai-extra = {
        version = "3.1.12.1";
        hash = "0lqcvc1akb3n2ldnzafjmrybzvy8386hz1bixi05awrv89d12q9m";
        repo = "hackage.haskell.org";
      };
      wai-logger = {
        version = "2.5.0";
        hash = "1l0gspzbwkrs1dqay2rv5wz1gg49a31l3vyl741b2j2apkgamf3p";
        repo = "hackage.haskell.org";
      };
      warp = {
        version = "3.3.21";
        hash = "1pm3dyd2pkby8ssbpsa9vf11vzsvphljsg10wraxyi2q3cqzlyhv";
        repo = "hackage.haskell.org";
      };
      wcwidth = {
        version = "0.0.2";
        hash = "0131h9vg8dvrqcc2sn0k8y6cb08fazlfhr4922hwv2vbx3cnyy3z";
        repo = "hackage.haskell.org";
      };
      wide-word = {
        version = "0.1.7.0";
        hash = "1kq41pg0fi3fa5zc58fsvksbzsr14c7zrnp78w21y6b53pgnliy9";
        repo = "hackage.haskell.org";
      };
      witherable = {
        version = "0.4.2";
        hash = "1ga4al351kwcfvsdr1ngyzj4aypvl46w357jflmgxacad8iqx4ik";
        repo = "hackage.haskell.org";
      };
      x509 = {
        version = "1.7.7";
        hash = "1pld1yx0fl6g4bzqfx147xipl3kzfx6pz8q4difw2k0kg0qj6xar";
        repo = "hackage.haskell.org";
      };
      x509-store = {
        version = "1.6.9";
        hash = "182hjs50x6w153j2a8k9myd2i1csvrz16hzms2ny0ygyxanqrd2z";
        repo = "hackage.haskell.org";
      };
      x509-system = {
        version = "1.6.7";
        hash = "0ccr0n2d1vv8v36rkz2cj8ilx2vldzg4cp3rs91277x0csfawwd5";
        repo = "hackage.haskell.org";
      };
      x509-validation = {
        version = "1.6.12";
        hash = "1jrsryn6hfdmr1b1alpj5zxvw26dw8y7kqpq555q2njm3kvwmxap";
        repo = "hackage.haskell.org";
      };
    };
  };
  solver = {
    latest = {
      bytebuild = {
        jailbreak = true;
      };
      chronos = {
        jailbreak = true;
      };
      exon = {
        version = "1.7.2.0";
        hash = "0hg271cvjqm4ps75qpnirq9nvjwpwb03mcbn1a364jrysrj6bg3b";
        repo = "hackage.haskell.org";
      };
      incipit = {
        jailbreak = true;
      };
      incipit-base = {
        jailbreak = true;
      };
      incipit-core = {
        jailbreak = true;
      };
      polysemy-chronos = {
        version = "0.7.0.1";
        hash = "1gc17p8xj77y0b8hjkbmsgw2ih5396mzlc6cjw5jmrviigsw726k";
        repo = "hackage.haskell.org";
      };
      polysemy-conc = {
        jailbreak = true;
      };
      polysemy-log = {
        jailbreak = true;
      };
      polysemy-process = {
        jailbreak = true;
      };
      polysemy-resume = {
        jailbreak = true;
      };
      polysemy-test = {
        jailbreak = true;
      };
      polysemy-time = {
        jailbreak = true;
      };
      prelate = {
        version = "0.8.0.0";
        hash = "0id72rbynmbb15ld8pv8nijll3k50x2mrpcqsv8dkbs7q05fn9vg";
        repo = "hackage.haskell.org";
      };
    };
    lower = {
      prelate = {
        version = "0.8.0.0";
        hash = "0id72rbynmbb15ld8pv8nijll3k50x2mrpcqsv8dkbs7q05fn9vg";
        repo = "hackage.haskell.org";
      };
    };
  };
  resolving = false;
}
