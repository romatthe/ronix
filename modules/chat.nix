{ config, pkgs, inputs, ... }:

{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users.romatthe = {
    home.packages = [
      pkgs.discord
      pkgs.fractal
      pkgs.signal-desktop
    ];
  };   
}
