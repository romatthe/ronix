let
  imports = import ../nix/sources.nix;
in { pkgs, config, lib, ... }: {
  nixpkgs.overlays = [
    (self: super:
      rec {
        inherit imports;

        nur = (import imports.NUR { pkgs = old; }).repos;
      });
  ];
}
