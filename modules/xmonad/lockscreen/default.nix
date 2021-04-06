{ config, pkgs, ... }:

{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users.romatthe = {
    services.screen-locker = {
      enable = true;
      inactiveInterval = 30;
      lockCmd = "${pkgs.betterlockscreen}/bin/betterlockscreen -l dim";
      xautolockExtraOptions = [
        "Xautolock.killer: systemctl suspend"
      ];
    };
  };
}
