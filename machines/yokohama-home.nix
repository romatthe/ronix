{ config, pkgs, lib, ... }:
{
    home.keyboard = {
        layout = "us";
    };

    # Configure monitor output
    xsession.profileExtra = "xrandr --output HDMI-1 --off --output DP-1 --primary --mode 3440x1440 --rate 100";
}