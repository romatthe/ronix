{ config, pkgs, inputs, ... }:

{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users.romatthe = {
    home.packages = [
      # Build-essentials
      pkgs.gcc
      pkgs.glibc
      pkgs.gnumake
      pkgs.cmake
      
      # Rust
      pkgs.rustup
    ];
  };
}
