{ config, pkgs, inputs, ... }:

{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users.romatthe = {
    # Emacs, with native-comp and pgtk support
    programs.emacs = {
      enable = true;
      package = pkgs.emacsGcc;
      extraPackages = (epkgs: [
        #epkgs.auctex
        epkgs.vterm
        epkgs.nix-mode
        epkgs.haskell-mode
      ]);
    };

    home.file.".emacs.d/init.el" = { source = ./init.el; recursive = true; };
  };

  fonts.fonts = with pkgs; [
    emacs-all-the-icons-fonts
    fira-code
  ];
}
