{ config, pkgs, inputs, ... }:

{
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME 3 Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome3.enable = true;
  
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users.romatthe = {
    gtk = {
      enable = true;
      theme.package = pkgs.gnome3.gnome_themes_standard;
      theme.name = "Adwaita-dark";
    };
  };
}
