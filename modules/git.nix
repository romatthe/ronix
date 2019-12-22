{ pkgs, config, lib, ... }:
{
  home-manager.users.romatthe = {
    programs.git = {
      enable = true;
      userEmail = "robin.mattheussen@gmail.com";
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
