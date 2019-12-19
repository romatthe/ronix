{ config, pkgs, lib, ... }:
{
  home-manager.users.romatthe = {
    home.packages = [
      pkgs.slack
    ];
  };
}

