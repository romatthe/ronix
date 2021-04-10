{ config, pkgs, inputs, ... }:

{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users.romatthe = {
    home.packages = [
      pkgs.sublime-music
      pkgs.spotify
    ];
  };   

}
