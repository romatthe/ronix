let
  sources = import ../nix/sources.nix;
in { pkgs, config, lib, ... }: {
  nixpkgs.overlays = [
    (self: super:
      rec {
        inherit sources;

        nur = (import sources.NUR { pkgs = import sources.nixpkgs {}; }).repos;
      })
  ];
}
