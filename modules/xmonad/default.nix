{ config, pkgs, lib, ... }:
{
  # Enable the Gnome Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = false;
  services.xserver.desktopManager.gnome3.enable = false;
  services.xserver = {
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      extraPackages = haskellPackages: [
        haskellPackages.xmonad-contrib
        haskellPackages.xmonad-extras
        haskellPackages.xmonad
        haskellPackages.monad-logger
        haskellPackages.taffybar
      ];
    };
    windowManager.default = "xmonad";
  };
  
  home-manager.users.romatthe = {
  #  xsession = {
  #    enable = true;
  #    windowManager = {
  #      xmonad = {
  #        enable = true;
  #        extraPackages = hpkgs: [
  #          hpkgs.xmonad-contrib
  #          hpkgs.xmonad-extras
  #          hpkgs.monad-logger
  #          hpkgs.taffybar
  #        ];
  #        enableContribAndExtras = true;
  #        config = ./xmonad.hs;
  #      };
  #    };
  #  };
    
    home.packages = with pkgs; [
      pkgs.gnome3.gnome-screensaver
      pkgs.rofi
      pkgs.stalonetray
      pkgs.trayer
    ];
  };

  fonts.fonts = with pkgs; [
    fira-code
  ];
}
