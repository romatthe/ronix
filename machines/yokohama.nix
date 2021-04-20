{ config, pkgs, ... }:
{
    imports = [
        ../hardware/yokohama-hardware.nix
#    ../modules/emacs
    #../modules/sway
    #../modules/sway/waybar.nix
#    ../modules/terminal
    #../modules/xmonad
    #../modules/xmonad/compositor
    #../modules/xmonad/dunst
    #../modules/xmonad/lockscreen
    #../modules/xmonad/polybar
#    ../modules/chat.nix
#    ../modules/dir-env.nix
#    ../modules/firefox.nix
#    ../modules/git.nix
#    ../modules/gnome.nix
#    ../modules/jetbrains.nix
#    ../modules/music.nix
#    ../modules/programming.nix
#    ../modules/virt.nix
    ];

    # Use the systemd-boot EFI boot loader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.efi.efiSysMountPoint = "/boot/efi";

    # Hostname
    networking.hostName = "yokohama"; # Define your hostname.

    # Set your time zone.
    time.timeZone = "Europe/Brussels";

    # Hopefully this will cover all wifi setups
    hardware.enableRedistributableFirmware = true;

    # Automatically update CPU microcode
    hardware.cpu.amd.updateMicrocode = true;

    # OpenGL support
    hardware.opengl.enable = true;
    hardware.opengl.driSupport = true;
    hardware.opengl.driSupport32Bit = true;

    # The global useDHCP flag is deprecated, therefore explicitly set to false here.
    # Per-interface useDHCP will be mandatory in the future, so this generated config
    # replicates the default behaviour.
    networking = {
        dhcpcd.enable = false;
        useNetworkd = true;
        useDHCP = false;
        interfaces.enp34s0.useDHCP = true;
        networkmanager = {
          enable = true;
          dns = "systemd-resolved";
        };
    };

    # TODO: Environmental variables?
    #environment.variables = (import ../../modules/common/globalvars.nix);

    # TODO: Virtualisation?
    #virtualisation = import (../../modules/virtualisation/default.nix);

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";
    console = {
        font = "Lat2-Terminus16";
        keyMap = "us";
    };

    # Configure keymap in X11
    services.xserver.layout = "us";
    services.xserver.deviceSection = ''
        Option "TearFree" "true"
    '';

    services.avahi.enable = true;

    # Enable sound.
    sound.enable = true;

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

    # Enable the OpenSSH daemon.
    services.openssh.enable = true;

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

