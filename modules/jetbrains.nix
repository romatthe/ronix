{ config, pkgs, lib, ... }:
{
  home-manager.users.romatthe = {
    home.packages = [
      pkgs.jetbrains.clion
      pkgs.jetbrains.goland
      pkgs.jetbrains.idea-community
      pkgs.jetbrains.rider
    ];
  };
}

