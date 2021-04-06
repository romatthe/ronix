{ config, lib, pkgs, ... }:

let
  polybarOpts = ''
    ${pkgs.nitrogen}/bin/nitrogen --restore &
    ${pkgs.pasystray}/bin/pasystray &
    ${pkgs.blueman}/bin/blueman-applet &
    ${pkgs.gnome3.networkmanagerapplet}/bin/nm-applet --sm-disable --indicator &
  '';  
in
{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  
  # System level services
  services = {
    gnome3.gnome-keyring.enable = true;

    # Power management, for laptop support
    upower.enable = true;

    dbus = {
      enable = true;
      packages = [
        pkgs.gnome3.dconf
      ];
    };

    xserver = {
      enable = true;
      layout = "us";

      # Touchpad for laptop support
      libinput = {
        enable = true;
        touchpad.disableWhileTyping = true;
      };

      # Enable GDM for a nice login screen
      displayManager = {
        gdm.enable = true;
        gdm.wayland = false;
        defaultSession = "none+xmonad";
      };

      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
      };

       xkbOptions = "caps:ctrl_modifier";
    };
  };

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
    
  systemd.services.upower.enable = true;
  
  # Home Manager
  home-manager.users.romatthe = {
    xsession = {
      enable = true;

      initExtra = polybarOpts;

      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
        extraPackages = haskellPackages: [
          haskellPackages.dbus
          haskellPackages.monad-logger
          haskellPackages.xmonad-contrib
        ];
        config = ./xmonad.hs;
      };
    };

    gtk = {
      enable = true;
      theme.package = pkgs.gnome3.gnome_themes_standard;
      theme.name = "Adwaita-dark";
      iconTheme.package = pkgs.gnome3.adwaita-icon-theme;
      iconTheme.name = "Adwaita-dark";
    };
    
    # Application launcher
    programs.rofi = {
      enable = true;
      terminal = "${pkgs.alacritty}/bin/alacritty";
    };

    # Auto disk mounting
    services.udiskie = {
      enable = true;
      tray = "always";
    };
  };

}
