let
  sources = import ../nix/sources.nix;
in { pkgs, config, lib, ... }: {
  nixpkgs.overlays = [
    (self: super:
      rec {
        inherit sources;

        unstable = import sources.nixpkgs {};
        
        nur = (import sources.NUR { pkgs = import sources.nixpkgs {}; }).repos;
      })
  ];
}
