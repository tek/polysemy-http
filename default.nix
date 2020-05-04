{
  nixpkgs ? import <nixpkgs>,
}:
let
  base = ./.;
  compiler = "ghc865";
  project = import ./ops/nix/project.nix { inherit base; };
  pkgs = import ./ops/nix/nixpkgs.nix { inherit nixpkgs project compiler base; };
  ghc = pkgs.haskell.packages.${compiler};
  ghci = import ./ops/nix/ghci.nix { inherit project pkgs; };
  ghcid = import ./ops/nix/ghcid.nix { inherit project pkgs ghci compiler; };
  tags = import ./ops/nix/tags.nix { inherit project compiler pkgs; };
in tags // {
  inherit pkgs project ghci ghcid compiler ghc;
}
