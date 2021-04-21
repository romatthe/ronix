{ pkgs, ... }:
{
    programs.starship.enable = true;
    programs.starship.enableFishIntegration = true;
    programs.starship.package = pkgs.unstable.starship;
    programs.starship.settings.add_newline = true;
    programs.starship.settings.character = {
      success_symbol = "[𝝺](#92d5ea)";
      vicmd_symbol = "[ ](bold green)";
      error_symbol = "[☓ ](bold red)";
    };
}