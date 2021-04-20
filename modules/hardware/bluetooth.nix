{ pkgs, ... }:
{
    hardware.bluetooth.enable = true;
    hardware.bluetooth.package = pkgs.bluezFull;
    hardware.bluetooth.config = {
        General = {
            # Disable Bluetooth LE and only enable BR/EDR
            ControllerMode = "bredr";
        };
    };
}