{ pkgs, ... }:

let
  build-script = import ./build-script.nix;
  
  mediaplayer = build-script pkgs "mediaplayer" ./waybar/mediaplayer {
    playerctl = "${pkgs.playerctl}/bin/playerctl";
    pango-escape-text = "${pango-escape-text}/bin/pango_escape_text";
  };
  
  pango-escape-text = build-script pkgs "pango_escape_text" ./waybar/pango-escape-text {
    python = "${(pkgs.python38.buildEnv.override {
      extraLibs = with pkgs.python38Packages; [ pygobject3 ];
    })}/bin/python";
  };
  
  play-pause = build-script pkgs "play-pause" ./waybar/play-pause {
    playerctl = "${pkgs.playerctl}/bin/playerctl";
  };
  
  media = { number } : {
    format = "{icon} {}";
    return-type = "json";
    max-length = 55;
    format-icons = {
      Playing = "";
      Paused = "";
    };
    exec = "${mediaplayer}/bin/mediaplayer ${number}";
    exec-if = "[ $(${pkgs.playerctl}/bin/playerctl -l | wc -l) -ge ${number} ]";
    interval = 1;
    on-click = "${play-pause}/bin/play-pause ${number}";
  };
in
{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.romatthe = {

    programs.waybar = {
      enable = true;
      package = pkgs.waybar.override { pulseSupport = true; };
      settings = [{
        height = 40;
        modules-left = [ "sway/workspaces" "sway/mode" "custom/media#1" "custom/media#2" ];
        modules-center = [];
        modules-right = [ "idle_inhibitor" "tray" "pulseaudio" "network" "memory" "cpu" "backlight" "clock" "custom/power" ];
        modules = {
          "sway/workspaces" = {
            all-outputs = true;
            format = "{icon}";
            format-icons = {
              "1" = "";
              "2" = "";
              "3" = "";
              "4" = "";
              "5" = "";
              "6" = "";
              "9" = "";
              "10" = "";
              focused = "";
              urgent = "";
              default = "";
            };
          };
          idle_inhibitor = {
            format = "{icon}";
            format-icons = {
              activated = "";
              deactivated = "";
            };
          };
          tray = {
            spacing = 10;
          };
          clock = {
            tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
            format-alt = "{:%A, %d %b}";
          };
          cpu = {
            format = "{usage}% ";
          };
          memory = {
            format = "{}% ";
          };
          backlight = {
            format = "{icon}";
            format-alt = "{percent}% {icon}";
            format-alt-click = "click-right";
            format-icons = [ "○" "◐" "●" ];
            on-scroll-down = "light -U 10";
            on-scroll-up = "light -A 10";
          };
          network = {
            format-wifi = "{essid} ({signalStrength}%) ";
            format-ethernet = "Ethernet ";
            format-linked = "Ethernet (No IP) ";
            format-disconnected = "Disconnected ";
            format-alt = "{bandwidthDownBits}/{bandwidthUpBits}";
            on-click-middle = "nm-connection-editor";
          };
          pulseaudio = {
            scroll-step = 1;
            format = "{volume}% {icon} {format_source}";
            format-bluetooth = "{volume}% {icon} {format_source}";
            format-bluetooth-muted = " {icon} {format_source}";
            format-muted = " {format_source}";
            format-source = "{volume}% ";
            format-source-muted = "";
            format-icons = {
              headphone = "";
              hands-free = "";
              headset = "";
              phone = "";
              portable = "";
              car = "";
              default = [ "" "" "" ];
            };
            on-click = "pavucontrol";
          };
          "custom/media#1" = media { number = "1"; };
          "custom/media#2" = media { number = "2"; };
          "custom/power" = {
      	    format = "";
      	    on-click = "nwgbar -o 0.2";
		        escape = true;
    	      tooltip = false;
          };
        };
      }];
      style = builtins.readFile ./waybar/style.css;
    };
    
  };
}
