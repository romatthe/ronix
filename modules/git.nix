{ config, pkgs, inputs, ... }:

{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users.romatthe = {
    # Git
    programs.git = {
      enable = true;
      userEmail = "me@romatthe.dev";
      userName = "Robin Mattheussen";
      signing = {
        signByDefault = true;
        key = "8DC3890E89EDE9DF";
      };
      extraConfig = {
        credential = {
          helper = "libsecret";
        };
      };
    };
  };
}
