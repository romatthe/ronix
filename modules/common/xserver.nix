{ pkgs, config, ... }:
{
    services.xserver.layout = "us";
    services.xserver.xkbVariant = "qwerty";
}