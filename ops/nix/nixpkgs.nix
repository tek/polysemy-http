{
  nixpkgs,
  project,
  compiler,
  base ? ../..,
}:
let
  overlay = self: super: {
    haskell = super.haskell // {
      packages = super.haskell.packages // {
        ${compiler} =
          (super.haskell.packages.${compiler}
          .override { overrides = import ./overrides.nix { inherit project base; pkgs = super; }; });
      };
    };
  };
in
  nixpkgs { overlays = [overlay]; }
