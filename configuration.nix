{ config, pkgs, lib, ... }:
let sources = import ./nix/sources.nix;
in {
  imports = [
    "${sources.home-manager}/nixos"
    ./machines/nagoya.nix
  ];
}
