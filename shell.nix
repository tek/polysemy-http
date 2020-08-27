let
  main = import ./.;
in
  main.ghcid.shell // {
    inherit (main) ghcid cabal;
  }
