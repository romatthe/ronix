{ config, pkgs, inputs, ... }:

{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users.romatthe = {

    home.packages = [
      pkgs.alacritty
      pkgs.sway-contrib.inactive-windows-transparency
      pkgs.udiskie
      pkgs.ulauncher
    ];

    home.file.".config/swaylock" = {
      source = ../config/swaylock;
      recursive = true;
    };

    gtk.enable = true;
    gtk.font.name = "SF Pro Display 11";
    gtk.gtk2.extraConfig = ''
      gtk-cursor-theme-name = "capitaine-cursors";
    '';                     
    gtk.gtk3.extraConfig = {
      gtk-cursor-theme-name = "capitaine-cursors";
    };
    gtk.iconTheme.package = iconTheme;
    gtk.iconTheme.name = "WhiteSur-icon-theme";
    gtk.theme.package = theme;
    gtk.theme.name = "WhiteSur-gtk-theme-light";

    wayland.windowManager.sway = {
      enable = true;
      package = pkgs.nixpkgs-extra.sway-borders;
      wrapperFeatures.gtk = true;
      
      config = {
        bars = [{ command = "waybar" }];
        fonts = [ "Font Awesome 5 Free 11" "Roboto 11" ];
        gaps.inner = 25;
        input."type:keyboard" = {
          xkb_layout = "us";
          xkb_variant = ",qwerty";
          xkb_numlock = "enabled";
        };
        menu = "${pkgs.ulauncher}/bin/ulauncher";
        modifier = "Mod4";
        #output."*" = { bg = "${wallpaper} fill"; };
        startup = [
          #{ command = "${lockScript}/bin/lock a"; }
          #{ command = "${pkgs.autotiling}/bin/autotiling"; }
          { command = "${pkgs.sway-contrib.inactive-windows-transparency}/bin/inactive-windows-transparency.py -o 0.9"; }
          { command = "${pkgs.udiskie}/bin/udiskie -s --appindicator --menu-update-workaround -f ${pkgs.gnome3.nautilus}/bin/nautilus"; }
          #{ command = "${import-gsettingsScript}/bin/import-gsettings"; always = true; }
        ];
        terminal = "${pkgs.alacritty}/bin/alacritty";
        window.border = 0;
        window.commands = let
          rule = command: criteria: { command = command; criteria = criteria; };
          floatingNoBorder = criteria: rule "floating enable, border none" criteria;
        in [
          (rule "floating enable, sticky enable, resize set 384 216, move position 1516 821" { app_id = "firefox"; title = "^Picture-in-Picture$"; })
          (floatingNoBorder { class = "jetbrains-toolbox"; })
          (floatingNoBorder { class = "jetbrains.*"; title = "Welcome.*"; })
          (floatingNoBorder { class = "jetbrains.*"; title = "win0"; })
          (floatingNoBorder { app_id = "ulauncher"; })
          (rule "floating enable" { class = "Tk"; })
        ];
      };
    
      extraConfig = ''
        seat seat0 xcursor_theme capitaine-cursors 24
        border_images.focused ${../config/border.png}
        border_images.focused_inactive ${../config/border.png}
        border_images.unfocused ${../config/border.png}
        border_images.urgent ${../config/border.png}
      ''
      extraSessionCommands = ''
        export XDG_SESSION_TYPE=wayland
        export XDG_SESSION_DESKTOP=sway
        export XDG_CURRENT_DESKTOP=sway
        export MOZ_ENABLE_WAYLAND=1
        export CLUTTER_BACKEND=wayland
        export QT_QPA_PLATFORM=wayland-egl
        export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
        export ECORE_EVAS_ENGINE=wayland-egl
        export ELM_ENGINE=wayland_egl
        export SDL_VIDEODRIVER=wayland
        export _JAVA_AWT_WM_NONREPARENTING=1
        export NO_AT_BRIDGE=1
        export SSH_AUTH_SOCK=/run/user/1000/gnupg/S.gpg-agent.ssh
      '';
    };

    programs.mako = {
      enable = true;
      anchor = "bottom-right";
      layer = "overlay";
      font = "Roboto 11";
      backgroundColor = "#2D3748";
      progressColor = "source #718096";
      textColor = "#F7FAFC";
      padding = "15,20";
      margin = "0,10,10,0";
      borderSize = 0;
      borderRadius = 4;
      defaultTimeout = 10000;
    };
    
  };
  
  # Required fonts
  fonts.fonts = with pkgs; [
    font-awesome
    roboto
  ];
}
