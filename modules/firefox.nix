{ config, pkgs, lib, ... }:
{
  home-manager.users.romatthe = {
    programs.firefox = {
      enable = true;
    };
  };
}
