# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

let
    nixpkgs-unstable = import inputs.nixpkgs-unstable { config = config.nixpkgs.config; localSystem = "x86_64-linux"; };
in
{
  imports = [
    ../modules/emacs
    ../modules/terminal
    ../modules/firefox.nix
    ../modules/git.nix
    ../modules/gnome.nix
    ../modules/virt.nix
  ];
  
  nix = {
    package = nixpkgs-unstable.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # Forgive me Stallman
  nixpkgs.config = { allowUnfree = true; };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  #boot.loader.grub = {
  #  enable = true;
  #  device = "nodev";
  #  version = 2;
  #  efiSupport = true;
  #  enableCryptodisk = true;
  #};

  # Grub menu is painted really slowly on HiDPI, so we lower the
  # resolution. Unfortunately, scaling to 1280x720 (keeping aspect
  # ratio) doesn't seem to work, so we just pick another low one.
  #boot.loader.grub.gfxmodeEfi = "1024x768";

  # Hostname
  networking.hostName = "yokohama"; # Define your hostname.

  # Set your time zone.
  time.timeZone = "Europe/Brussels";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp34s0.useDHCP = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Configure keymap in X11
  services.xserver.layout = "us";

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.romatthe = {
    description = "Robin Mattheussen";
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
    hashedPassword = "$6$3jnb5.ogAjaHO7t$.bz.QVZVPTPUe75.0HuTPhThVgrH9GFyuvqUwyTvtNvKFumw3WckiOnEfmoy/Ojewf2HwH0PLnc4Hc7bKqw57/";
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget vim git htop
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?
}

