{ config, pkgs, inputs, ... }:

{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users.romatthe = {
    programs.direnv.enable = true;
    programs.direnv.enableNixDirenvIntegration = true;   
  };
}
