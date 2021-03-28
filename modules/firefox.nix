{ config, pkgs, inputs, ... }:

{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users.romatthe = {
    programs.firefox = {
      enable = true;
      extensions =
        with pkgs.nur.repos.rycee.firefox-addons; [
          pkgs.nur.repos.rycee.firefox-addons.bitwarden
          pkgs.nur.repos.rycee.firefox-addons.privacy-badger
          pkgs.nur.repos.rycee.firefox-addons.ublock-origin
        ];
    };
  };
}
