{ config, pkgs, inputs, ... }:

{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users.romatthe.gtk = {
    enable = true;
    theme.name = "adwaita-dark";
  };
 
  home-manager.users.romatthe.programs.zsh.enable = true;

  home-manager.users.romatthe.programs.firefox = {
    enable = true;
    extensions =
      with pkgs.nur.repos.rycee.firefox-addons; [
        nur.repos.rycee.bitwarden
      ];
  };
}
