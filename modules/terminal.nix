{ config, lib, pkgs, ... }:
let
  unstableTarball =
    fetchTarball
      https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz;
in
{
  home-manager.users.romatthe = { 
    programs.alacritty = {
      enable = true;
      settings = {
      
        env = {
          "TERM" = "xterm-256color";
        };

        background_opacity = 0.95;

        window = {
          padding.x = 10;
          padding.y = 10;
          decorations = "none";
        };

        font = {
          size = 11.0;
          use_thin_strokes = true;

    	  normal.family = "FuraCode Nerd Font";
    	  bold.family = "FuraCode Nerd Font";
    	  italic.family = "FuraCode Nerd Font";
        };

        cursor.style = "Block";

        shell = {
          program = "nu";
        };
      };
    };
    
    home.packages = [
      pkgs.neofetch
    ];

  };

  # Allow installing packages from unstable (for nushell)
  nixpkgs.config = {
    packageOverrides = pkgs: {
      unstable = import unstableTarball {
        config = config.nixpkgs.config;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    unstable.nushell
  ];

  environment.sessionVariables.TERMINAL = [ "alacritty" ];

  fonts.fonts = with pkgs; [
    nerdfonts
  ];
}
