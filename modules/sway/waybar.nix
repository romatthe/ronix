{ pkgs, ... }:

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
      style = builtins.readFile ../config/waybar/style.css;
    };
    
  };
}
