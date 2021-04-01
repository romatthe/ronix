{ config, pkgs, inputs, ... }:

{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  
  home-manager.users.romatthe = {
    home.packages = [
      pkgs.jetbrains.clion
      pkgs.jetbrains.goland
      pkgs.jetbrains.idea-community
    ];
  };
}
