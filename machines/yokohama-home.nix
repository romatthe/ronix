{ config, pkgs, inputs, ... }:

{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users.romatthe = {
    gtk = {
      enable = true;
      theme.package = pkgs.gnome3.gnome_themes_standard;
      theme.name = "Adwaita-dark";
    };
 
    programs.zsh.enable = true;

    # Firefox
    programs.firefox = {
      enable = true;
      extensions =
        with pkgs.nur.repos.rycee.firefox-addons; [
          pkgs.nur.repos.rycee.firefox-addons.bitwarden
          pkgs.nur.repos.rycee.firefox-addons.privacy-badger
          pkgs.nur.repos.rycee.firefox-addons.ublock-origin
        ];
    };

    # Emacs, with native-comp and pgtk support
    programs.emacs = {
      enable = true;
      package = pkgs.emacsGcc;
      extraPackages = (epkgs: [ 
        epkgs.vterm
        epkgs.nix-mode
      ]);
    };

    # Git
    programs.git = {
      enable = true;
      userEmail = "me@romatthe.dev";
      userName = "Robin Mattheussen";
      signing = {
        signByDefault = true;
        key = "8DC3890E89EDE9DF";
      };
      extraConfig = {
        credential = {
          helper = "libsecret";
        };
      };
    };
  };
}
