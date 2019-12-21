{ config, pkgs, lib, ... }:
{
  home-manager.users.romatthe = {
    home.packages = [
      pkgs.brogue
      pkgs.cataclysm-dda
      pkgs.crawl
      pkgs.dwarf-fortress
      pkgs.exult
      pkgs.freeciv
      pkgs.ivan
      pkgs.openttd
      pkgs.openxcom
      pkgs.wesnoth
    ];
  };
}
