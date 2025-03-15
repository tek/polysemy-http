{
  bounds = {
    polysemy-http = {
      aeson = {
        lower = "2.1.0.0";
        upper = "2.3";
      };
      base = {
        lower = "4.17.2.1";
        upper = "4.20";
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
        lower = "1.2";
        upper = "1.5";
      };
      http-client = {
        lower = "0.7.0";
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
        upper = "3.2";
      };
      polysemy = {
        lower = "1.9.0.0";
        upper = "1.10";
      };
      polysemy-plugin = {
        lower = "0.4.4.0";
        upper = "0.5";
      };
      polysemy-test = {
        lower = "0.9.0.0";
        upper = null;
      };
      prelate = {
        lower = "0.8.0.0";
        upper = "0.9";
      };
      servant = {
        lower = "0.20.1";
        upper = null;
      };
      servant-client = {
        lower = "0.20";
        upper = "0.21";
      };
      servant-server = {
        lower = "0.20";
        upper = "0.21";
      };
      tasty = {
        lower = "1.4";
        upper = "1.5";
      };
      tasty-hedgehog = {
        lower = "1.4.0.0";
        upper = "1.5";
      };
      time = {
        lower = "1.12.2";
        upper = "1.13";
      };
      warp = {
        lower = "3.4.0";
        upper = "3.5";
      };
    };
  };
  versions = {
    latest = {
      aeson = "2.2.3.0";
      base = "4.19.2.0";
      case-insensitive = "1.2.1.0";
      exon = "1.7.2.0";
      hedgehog = "1.4";
      http-client = "0.7.18";
      http-client-tls = "0.3.6.4";
      http-types = "0.12.4";
      network = "3.1.4.0";
      polysemy = "1.9.2.0";
      polysemy-plugin = "0.4.5.2";
      prelate = "0.8.0.0";
      servant-client = "0.20.2";
      servant-server = "0.20.2";
      tasty = "1.4.3";
      tasty-hedgehog = "1.4.0.2";
      time = "1.12.2";
      warp = "3.4.7";
    };
    lower = {
      aeson = "2.1.0.0";
      base = "4.17.2.1";
      case-insensitive = "1.2.0.11";
      exon = "1.4.0.0";
      hedgehog = "1.2";
      http-client = "0.7.0";
      http-client-tls = "0.3.0";
      http-types = "0.12.3";
      network = "3.1.2.9";
      polysemy = "1.9.0.0";
      polysemy-plugin = "0.4.4.0";
      polysemy-test = "0.9.0.0";
      prelate = "0.8.0.0";
      servant = "0.20.1";
      servant-client = "0.20";
      servant-server = "0.20";
      tasty = "1.4";
      tasty-hedgehog = "1.4.0.0";
      time = "1.12.2";
      warp = "3.4.0";
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
      polysemy-test = "0.9.0.0";
      prelate = "0.8.0.0";
      servant = "0.20.1";
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
      auto-update = {
        version = "0.2.6";
        hash = "0sp25j3fcgmfr2zv1ccg1id1iynj3azinjg23g0vy1m1m7gnmkzi";
      };
      exon = {
        version = "1.7.2.0";
        hash = "0hg271cvjqm4ps75qpnirq9nvjwpwb03mcbn1a364jrysrj6bg3b";
      };
      fast-logger = {
        version = "3.2.5";
        hash = "0872c6clb0p7js9g3p8xn2xfr97d0zqi8rp8zlxl5hpy5q32jlli";
      };
      http-client = {
        version = "0.7.18";
        hash = "0dchgz63m1n6v32ph275r3hlv5grz54zlfcgwiaipai3b45imiks";
      };
      http-client-tls = {
        version = "0.3.6.4";
        hash = "1f8br94l5kywpsfvpmw54b1v6nx1yapslzrwiswsf6vf8kwfjjzg";
      };
      http-semantics = {
        version = "0.3.0";
        hash = "0ghj37jr5bsz047p6i66ddkwc9mxkfpbw14nd54slmj1lpwn5z4a";
      };
      http2 = {
        version = "5.3.9";
        hash = "19lzz6y1rzsbyfswfp9zg9gszmimvfib72dg60x6f19lvmnziga8";
      };
      network-control = {
        version = "0.1.4";
        hash = "00kb50jj14661p0bfb2hgzrq93z9rjch082hp6wda65hvgxfz289";
      };
      prelate = {
        version = "0.8.0.0";
        hash = "0id72rbynmbb15ld8pv8nijll3k50x2mrpcqsv8dkbs7q05fn9vg";
      };
      servant-client = {
        version = "0.20.2";
        hash = "06z73lqxfp4r5rfv9xfb7a0vr2k2aia95qfcg21rwzyhrc77fndk";
      };
      servant-server = {
        version = "0.20.2";
        hash = "1xp86ha73fkqbsxyycr0wga0k106vfb4kpjyzh055l2qb47kyj9j";
      };
      time-manager = {
        version = "0.2.2";
        hash = "1ja8pimvy07b05ifkrg6q0lzs3kh0k2dmncwjdxl81199r559vf5";
      };
      wai-app-static = {
        version = "3.1.9";
        hash = "1kwvzy9w4v76q5bk4xwq7kz9q9l8867my6zvsv731x6xkhy7wr2c";
      };
      wai-extra = {
        version = "3.1.17";
        hash = "0lvsv014k2fpd3rm99qkfkh47zic7wg39zgv7g7ll06515ly23w9";
      };
      wai-logger = {
        version = "2.5.0";
        hash = "1l0gspzbwkrs1dqay2rv5wz1gg49a31l3vyl741b2j2apkgamf3p";
      };
      warp = {
        version = "3.4.7";
        hash = "1bc3g094d2j0w6wkh1g1hw0br3kcl4v3mczmyxhq2rcpkzwqjwa1";
      };
    };
    lower = {
      OneTuple = {
        version = "0.3.1";
        hash = "0mb81j6zhvzq7h9yyhi9cszrq1g5d4lv3a8wpwimcvzbyg9bdd6p";
      };
      adjunctions = {
        version = "4.4.3";
        hash = "1k940bpa8qiqrj6hh8jh2vshdfdisi827i3l6m2hwajc4yhjlrgg";
      };
      aeson = {
        version = "2.1.0.0";
        hash = "08s162yh716aaxd42k1kyv18p9nsyab42ns4340kvs6r0i8riwsi";
      };
      ansi-terminal = {
        version = "0.11.5";
        hash = "0g7ycc2b67z8plqp7hva914yhwzjmvvhhf9mszlhj3kqxh6i732b";
      };
      assoc = {
        version = "1.0.2";
        hash = "1sfc21z18sf8rpsbcr77kgw7qjpm5cm1d24n5ifsm2zid88v8fs9";
      };
      atomic-primops = {
        version = "0.8.8";
        hash = "1razf9zq71am8x1813rrq8m14z6lnrkaacw4zcr5rii6f1q1l6xh";
      };
      attoparsec = {
        version = "0.14.4";
        hash = "0y9dph5axyvr1bfcvmz6qh50bjcp50m2ljra14960anc6g74a3c8";
      };
      attoparsec-iso8601 = {
        version = "1.1.0.0";
        hash = "0jjkgma9k55mhjhrc178kh19366x3b4abddvqhsmcrd7wqcvcb40";
      };
      base-compat = {
        version = "0.12.3";
        hash = "0vnns2imggv0b9gbbd9k0p8hdwlimka50gqbvknwkwbnv3kil7lb";
      };
      base-compat-batteries = {
        version = "0.12.3";
        hash = "0jg1wki5qbghjd5ra23ldc69jal9jjwrwp6wz8gg4gcrjlxbwg7m";
      };
      bifunctors = {
        version = "5.5.15";
        hash = "0qymwahcn7nqw3n9hvgh0nqhpm6p2ci1grmnwwfplvhxsaka91aj";
      };
      bytebuild = {
        version = "0.3.16.3";
        hash = "1qka0dr6g534vi8p3iwlshdi1iklhgaajg9fbbzvkg49pzj1sak7";
      };
      byteslice = {
        version = "0.2.14.0";
        hash = "1ih3g6zcdnlk3y3z4h083jncydai8c0gs240dxih3wwi0d1n2vm9";
      };
      bytesmith = {
        version = "0.3.11.1";
        hash = "0pkmxlww2g20lfq22s5n332ff9mh0a5qjmlvvi4bh8mbf6r2jc1m";
      };
      cabal-doctest = {
        version = "1.0.11";
        hash = "152rqpicqpvigjpy4rf1kjlwny1c7ys1r0r123wdjafvv1igflii";
      };
      case-insensitive = {
        version = "1.2.0.11";
        hash = "0nn4hffa6i3sf6n1cg69br7qiwsc3shw26ay9bkwhkff6lfpw1bj";
      };
      chronos = {
        version = "1.1.6.2";
        hash = "1pbfp25py682d17visa4i9rjxmiim8aykrgs7nv2q9anajv88kdx";
      };
      concurrent-output = {
        version = "1.10.21";
        hash = "1w87rrf337s8wc4z3dkh2mk990003jsk18ry5yawv4465k4yvamw";
      };
      connection = {
        version = "0.3.1";
        hash = "0qjdz2fxxszbns7cszhnkwm8x8l3xlnad6iydx2snfi416sypiy0";
      };
      contiguous = {
        version = "0.6.4.2";
        hash = "1vkqnggzniw24241lrmww7bmpprcpn12z5rrskxpq33wmad3wvsz";
      };
      cryptonite = {
        version = "0.30";
        hash = "04wq8lh300dng87n59a37ngjqbwjlxpd62vz6ifvz0gpyx0pnhy7";
      };
      exon = {
        version = "1.4.0.0";
        hash = "1m4i3a14wip985ncblfy2ikcy7gw5rryj9z497ah218d1nmwj7rl";
      };
      flatparse = {
        version = "0.4.1.0";
        hash = "0z9q5qb3yz4phvj1wq06dld745m98yk4gvkmj1vkq7hda0mn182a";
      };
      free = {
        version = "5.2";
        hash = "0b646kh0jwyswi548z1maqjircac4c80zfm0fz06jr0yd0ydrjq1";
      };
      generic-lens = {
        version = "2.2.2.0";
        hash = "08z7x2vylam9v5f4z62k3qs7phdzlks6a5g0nn2w5cczqpg6ybjd";
      };
      generics-sop = {
        version = "0.5.1.3";
        hash = "1xj700x702xwggfd6dg2wya1gnnsb1p32nzi00f1am49xjy2alh1";
      };
      ghc-hs-meta = {
        version = "0.1.5.0";
        hash = "19z2704dl6x4lkgfaynhn550wdghpj9qdwh5xr96drp3nkh012dl";
      };
      haskell-src-meta = {
        version = "0.8.15";
        hash = "0ccwgfkb1n31wwfysdhc1mqpcnnxnczwmz3d4avm9yn9a5m1nh4s";
      };
      hedgehog = {
        version = "1.2";
        hash = "1jak5p9qhnv8zq761wxbdygpj107llpi66m6d7hiaywymqq47giw";
      };
      hsc2hs = {
        version = "0.68.10";
        hash = "0wdg17kicnp6qbgynha216vihx7nnsglvhn5c089dqpa14hg35zw";
      };
      http-api-data = {
        version = "0.5.1";
        hash = "0mk0dkfq6rrrw4kh5c4b68ykzaynh2w7gkqbxffs220cbjipapva";
      };
      http-client = {
        version = "0.7.0";
        hash = "1hr6a1rfksaddw3cvi4g40jq5xn2mxpcd9309v8fxbiw66hbs7bh";
      };
      http-client-tls = {
        version = "0.3.0";
        hash = "08rwd8xmiq4ppxfzid9x01vr9b5sq7zbzc7kad1gashh4ybfd921";
      };
      http-date = {
        version = "0.0.11";
        hash = "1f3hq5s6q54r4sv68h9fpafw9z52x2iqc6bwqkjw11v9d1x13mh1";
      };
      http-media = {
        version = "0.8.1.1";
        hash = "10rxh1brpi9gsjrhgf5227z1gxrliipmiagp6j300jdgpf3rk8f3";
      };
      http-semantics = {
        version = "0.0.0";
        hash = "0jdlakynqm1vm22kb1g1g1mh7h0ihk7mx8l2zzvdaqmqn10lwmh4";
      };
      http-types = {
        version = "0.12.3";
        hash = "0239y1r25n7wnnf2ci5lajj0rf35j2ywa07f9lpccnry13zbh8dv";
      };
      http2 = {
        version = "5.2.0";
        hash = "12zrgymnbsc9ybz1mz0a183vzrpawrsv9hmhhsnrbxqc2im6g52k";
      };
      incipit = {
        version = "0.10.0.1";
        hash = "0vr1balwy6v9l15pjlyy372w0scli1wcl6395jqdkjncqm3ymdin";
      };
      incipit-core = {
        version = "0.5.1.0";
        hash = "04lyzycvqxyjqcd703cd33lnlk5va9wj3czpsybah0ybydnrwabd";
      };
      indexed-traversable-instances = {
        version = "0.1.2";
        hash = "05vpkasz70yjf09hsmbw7nap70sr8p5b7hrsdbmij8k8xqf3qg8r";
      };
      invariant = {
        version = "0.6.3";
        hash = "1dl7jslb3y4csj1s01b7q0i175ad9mgira39gv7f1jv72cnnrp5a";
      };
      iproute = {
        version = "1.7.15";
        hash = "1a6kjmm0kqqalyc8qbaa6pwnz7nlclfphqmnxxq8f4yhaa4xd19j";
      };
      kan-extensions = {
        version = "5.2.6";
        hash = "1yl3w6a99k56qk72wnlxmd61j9k00i8rvjx8h7cgdi60ib2w7a7k";
      };
      network = {
        version = "3.1.2.9";
        hash = "0cqiv0fjsa6yi1kqal6q290bx5nakp4yayq98b6p6rmmgzv96xfy";
      };
      network-control = {
        version = "0.1.4";
        hash = "00kb50jj14661p0bfb2hgzrq93z9rjch082hp6wda65hvgxfz289";
      };
      optparse-applicative = {
        version = "0.18.1.0";
        hash = "0wggvi67lm2amw0igmpfqs75jvy91zv42v33c12vmk9fdqkwalmg";
      };
      path = {
        version = "0.9.5";
        hash = "05b84rizmrii847pq2fbvlpna796bwxha1vc01c3vxb2rhrknrf7";
      };
      path-io = {
        version = "1.8.2";
        hash = "063ma7gzqr5c6s8a1yv72jgll3xdajvgclbc8w0ddmqgcrb62x2k";
      };
      polysemy = {
        version = "1.9.0.0";
        hash = "1af07cppnjpv5v56wanya1mhkvbfnyynf5447mnkcf4zc4k23pyk";
      };
      polysemy-chronos = {
        version = "0.6.0.2";
        hash = "1wvjpl2axxhywjj7z1hjg16sxldq0x63md4rzf1mvdn8067mg35s";
      };
      polysemy-conc = {
        version = "0.14.1.1";
        hash = "1xli6ja9f7qx2k9956lw4h9y5ywdglhgw769afxw9d4w9avclx28";
      };
      polysemy-log = {
        version = "0.11.0.0";
        hash = "1phzwj2ig0vx1anscg3qv53ysa0f7gks37pc8gfkh2aws3qp6cda";
      };
      polysemy-plugin = {
        version = "0.4.4.0";
        hash = "08ry72bw78fis9iallzw6wsrzxnlmayq2k2yy0j79hpw4sp8knmg";
      };
      polysemy-process = {
        version = "0.14.1.1";
        hash = "1qvbkldhai77r2pr7wbznsb9pr0pawynmvcd31v3v8jpki3xaycr";
      };
      polysemy-resume = {
        version = "0.9.0.1";
        hash = "1i2bnpd3l357jhln8xl92z65b3mskz9y8z1xlha4lm0m855qyk15";
      };
      polysemy-test = {
        version = "0.9.0.0";
        hash = "1adkp48v04klsjyv8846w7ryf1fiqxb4ga69mps9vg2bp9fj5i7j";
      };
      polysemy-time = {
        version = "0.6.0.2";
        hash = "198x2wimdzk93hz0bq2k7wjibcjvzm38m6fica1jfcbh4p531swp";
      };
      prelate = {
        version = "0.8.0.0";
        hash = "0id72rbynmbb15ld8pv8nijll3k50x2mrpcqsv8dkbs7q05fn9vg";
      };
      prettyprinter-ansi-terminal = {
        version = "1.1.3";
        hash = "09m8knzfvms12576pp2nrdn7j0wikylwjfr9r3z4swgipz1r3nki";
      };
      primitive = {
        version = "0.7.4.0";
        hash = "0n7r8al9wgz4r7jzizapn1dbnkqxwx2c4lqkgfm5q5bxj8fl7g1c";
      };
      primitive-addr = {
        version = "0.1.0.3";
        hash = "0b01fgjlh380sax6n20sjlw8lfalirhjxaf1iv2qgifzv2sc0xwk";
      };
      primitive-offset = {
        version = "0.2.0.1";
        hash = "0c5rvyfbh3ly6p38p5cnikh6a0is7gn7fj0ddn168c8df1cqalw5";
      };
      primitive-unlifted = {
        version = "2.2.0.0";
        hash = "1z4nh2pv9ylbc9mw9dfmjschyn6ci0rqhz5nn9mld3wz45a15aq5";
      };
      profunctors = {
        version = "5.6.2";
        hash = "19gnn2br16x52lmvfjj06xblsks0wz3081z0jf0jydncbgm6kfan";
      };
      recv = {
        version = "0.1.0";
        hash = "0nsis8kzq86vck8v932c53gp3ci9i0zbkny4il080rd6pxhmq1mm";
      };
      resourcet = {
        version = "1.3.0";
        hash = "0ffmm850z3n95vyj33gfqk606kfn6d50b9bnylqn8y4zrcv5yjmk";
      };
      run-st = {
        version = "0.1.3.3";
        hash = "1x5brxdbncfgzvdl8k6h00zpzzv319j7iw3k5lgrimhdm0jz2vz7";
      };
      scientific = {
        version = "0.3.7.0";
        hash = "09iwj0snmx7vj7x03l4vdcn76zylcgxd9pyz0yxkydgfnn3lvc08";
      };
      semialign = {
        version = "1.2.0.1";
        hash = "0mpw54c3s0x70k5l52a57yhnmbgrksb3dn0vjq4m37spyzsfl1v2";
      };
      semigroupoids = {
        version = "5.3.7";
        hash = "0sknyh441xrna6w6d65j189n59najbp8h7g2ndr9qswxh7z2qaf1";
      };
      servant = {
        version = "0.20.1";
        hash = "0sfm498h5n0ffwfx6fwrjxif6j34mcy0h91kpq9y3asyaaqw76y2";
      };
      servant-client = {
        version = "0.20";
        hash = "0iv254h277vfmmwq14807bcdwyi0xccs6dl5k75gqgwn3aawza11";
      };
      servant-client-core = {
        version = "0.20";
        hash = "0yp41xpvzrqazjvmlvfj0hs19ilsxwwsv3bkxzc3kd3i841bbr98";
      };
      servant-server = {
        version = "0.20";
        hash = "0ryjsm35qnmkrz9mdm34irvphx0s8898a6kz041akjn6hry09dcj";
      };
      simple-sendfile = {
        version = "0.2.31";
        hash = "0cxxgg46b709lk5302jcipipg0yx0aqlzn5h28a6ds9sk3lx6rsi";
      };
      socks = {
        version = "0.6.1";
        hash = "0750g9cd22w0hlxcz8hrghlrbgsyja3x994d9m7sq5jh3s52da92";
      };
      streaming-commons = {
        version = "0.2.3.0";
        hash = "13adg89zx9qzirw9ibmz70qnbwgnhmzjkbp4fh6l6qskfh1fyysm";
      };
      strict = {
        version = "0.4.0.1";
        hash = "0xhr98m2632k2pic8q9bpnm3mp9098mmg4s66ds052b92494k49f";
      };
      string-conversions = {
        version = "0.4.0.1";
        hash = "06rfwj2bb8m2by6h2xja69r45rghmil9ali5i89khfh46nnadjpq";
      };
      tasty = {
        version = "1.4";
        hash = "0wmnc2538ia9vgz8394hg6wjfd4zxgyfk4k6j5gdhic6hpjfdw7f";
      };
      tasty-hedgehog = {
        version = "1.4.0.0";
        hash = "131zswqfl4azl6ylxlqpr5ilr0l6qvjs2va21mf0246pgf9dvpdx";
      };
      th-abstraction = {
        version = "0.4.5.0";
        hash = "19nh7a9b4yif6sijp6xns6xlxcr1mcyrqx3cfbp5bdm7mkbda7a9";
      };
      th-expand-syns = {
        version = "0.4.12.0";
        hash = "05p82h3hb7ayidc98qq2bgj790d7km9ixp5ijgc1qqkksg3php6z";
      };
      th-lift = {
        version = "0.8.4";
        hash = "0rp32lkvx22alxc7c1mxgf224jyanfy93ry70zwdn6zzj50mnbhc";
      };
      th-orphans = {
        version = "0.13.16";
        hash = "1ih88wwgrxmj04awk0693pjhi19grhh33c6ckc0gckvkisp5lyb5";
      };
      th-reify-many = {
        version = "0.1.10";
        hash = "0g9axz1iszl02cxvy2zgmzinjvz8pbsfq3lzhspshlw5bgcsld39";
      };
      these = {
        version = "1.1.1.1";
        hash = "1i1nfh41vflvqxi8w8n2s35ymx2z9119dg5zmd2r23ya7vwvaka1";
      };
      tls = {
        version = "1.6.0";
        hash = "1bw3y5bxxpa3xncvh6g8z8x5gxz8kjl2didk229m7l79jvcicijy";
      };
      tuples = {
        version = "0.1.0.0";
        hash = "1cn7cjrsigimwmxnw1jm1fvaw5r9k4dia9jwwbc0yx7wc9rj8gyx";
      };
      type-errors = {
        version = "0.2.0.2";
        hash = "09rkyqhx8jnzqiq7gpcm5jd1xd435h0ma0b2sff18lk31qv01x6g";
      };
      unagi-chan = {
        version = "0.4.1.4";
        hash = "1glfzdm732p0zbwq6vg0syw4cg7f72k1982rc6ha8wyr46czdlmm";
      };
      unbounded-delays = {
        version = "0.1.1.1";
        hash = "1kbh2yr7lwzrhjniyfllsix2zn8bmz9yrkhnq5lxv9ic9bbxnls7";
      };
      unordered-containers = {
        version = "0.2.20";
        hash = "0dvlf9by7mkwaxg2x26m6bf5bnqr1l07j6adksavvziiq0x3p135";
      };
      uuid-types = {
        version = "1.0.5.1";
        hash = "0kf0877vz9zd9vb9ljab2vx010s6rqq5jskbdlw3nc5b25ycsj3f";
      };
      vector = {
        version = "0.13.2.0";
        hash = "0mgc7ikhdgqwsj5skdxsf6v3a1iqkiiysqj94qnbg40ff8nbai4x";
      };
      wai = {
        version = "3.2.4";
        hash = "1vxagql34hjvnrw0116kx6z5wnj4gcddf36kfs65f6zr2ib6c11l";
      };
      wai-app-static = {
        version = "3.1.9";
        hash = "1kwvzy9w4v76q5bk4xwq7kz9q9l8867my6zvsv731x6xkhy7wr2c";
      };
      wai-extra = {
        version = "3.1.17";
        hash = "0lvsv014k2fpd3rm99qkfkh47zic7wg39zgv7g7ll06515ly23w9";
      };
      wai-logger = {
        version = "2.5.0";
        hash = "1l0gspzbwkrs1dqay2rv5wz1gg49a31l3vyl741b2j2apkgamf3p";
      };
      warp = {
        version = "3.4.0";
        hash = "1iskx4vxb3f8b0qfqwxyljgv801sh9jw3kfc1vxxr0j0zlvy3j7r";
      };
      wcwidth = {
        version = "0.0.2";
        hash = "0131h9vg8dvrqcc2sn0k8y6cb08fazlfhr4922hwv2vbx3cnyy3z";
      };
      wide-word = {
        version = "0.1.7.0";
        hash = "1kq41pg0fi3fa5zc58fsvksbzsr14c7zrnp78w21y6b53pgnliy9";
      };
      witherable = {
        version = "0.4.2";
        hash = "1ga4al351kwcfvsdr1ngyzj4aypvl46w357jflmgxacad8iqx4ik";
      };
      x509 = {
        version = "1.7.7";
        hash = "1pld1yx0fl6g4bzqfx147xipl3kzfx6pz8q4difw2k0kg0qj6xar";
      };
      x509-store = {
        version = "1.6.9";
        hash = "182hjs50x6w153j2a8k9myd2i1csvrz16hzms2ny0ygyxanqrd2z";
      };
      x509-system = {
        version = "1.6.7";
        hash = "0ccr0n2d1vv8v36rkz2cj8ilx2vldzg4cp3rs91277x0csfawwd5";
      };
      x509-validation = {
        version = "1.6.12";
        hash = "1jrsryn6hfdmr1b1alpj5zxvw26dw8y7kqpq555q2njm3kvwmxap";
      };
    };
  };
  resolving = false;
}
