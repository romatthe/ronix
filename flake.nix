{
    description = "Collection of my systems configured through Nix flakes";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-20.09";
        nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
        nixpkgs-master.url = "github:nixos/nixpkgs/master";
        nixpkgs-extra = {
            url = "github:romatthe/nixpkgs-extra";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        nur.url = "github:nix-community/NUR";
        emacs.url = "github:nix-community/emacs-overlay";

        home-manager = {
            url = "github:rycee/home-manager/release-20.09";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    # TODO: Apply Nord theme to every module!!!

    outputs = { self, nixpkgs, nur, home-manager, ... } @ inputs:
        let
            inherit (builtins) listToAttrs attrValues attrNames readDir;
            inherit (nixpkgs) lib;
            inherit (lib) removeSuffix;

            pkgs = (import nixpkgs) {
                system = "x86_64-linux";
                config = {
                    # Forgive me Stallman
                    allowUnfree = true;
                };
                overlays = attrValues self.overlays;
            };

            defaults = { pkgs, ... }: {
                imports = [
#                    ./cachix.nix
                    ./modules/common/etcfiles.nix
                    ./modules/common/nix.nix
#                   ./modules/common/doas.nix
                    ./modules/common/console.nix
                    ./modules/hardware/bluetooth.nix
                    ./modules/hardware/earlyoom.nix
                    ./modules/hardware/pulseaudio.nix
#                   ./modules/hardware/zram.nix
#                   ./modules/common/etcfiles.nix
#                   ./modules/common/systempackages.nix
#                   ./modules/common/globallocale.nix
#                   ./modules/services/clamav.nix
#                   ./modules/services/openssh.nix
                ];
            };
        in
        {
            overlays =
                let
                    overlayFiles = listToAttrs (map
                        (name: {
                            name = removeSuffix ".nix" name;
                            value = import (./overlays + "/${name}");
                        })
                        (attrNames (readDir ./overlays)));
                in
                    overlayFiles // {
                        nur = final: prev: {
                            nur = import inputs.nur { nurpkgs = final.unstable; pkgs = final.unstable; };
                        };
                        emacs-overlay = inputs.emacs.overlay;
                        unstable = final: prev: {
                            unstable = import inputs.nixpkgs-unstable {
                                system = final.system;
                                config = {
                                    allowUnfree = true;
                                };
                            };
                        };
                        master = final: prev: {
                            master = import inputs.nixpkgs-master {
                                system = final.system;
                                config = {
                                    allowUnfree = true;
                                };
                            };
                        };
                    };


            # Systems
            nixosConfigurations = {
      
                # Yokohama, home desktop workhorse
                yokohama = nixpkgs.lib.nixosSystem {
                    system = "x86_64-linux";
                    modules = [
                        defaults
                        # TODO: System packages here!
                        ./modules/common/fonts.nix
                        ./modules/common/xserver.nix
                        ./modules/hardware/ssd.nix
                        (import ./hardware/yokohama-hardware.nix)
                        (import ./machines/yokohama.nix)
                        home-manager.nixosModules.home-manager
                            ({
                                home-manager.useGlobalPkgs = true;
                                home-manager.useUserPackages = true;
                                home-manager.users.romatthe = { ... }: {
                                    imports = [
                                        ./machines/yokohama-home.nix
                                        ./modules/terminal/alacritty.nix
                                        # TODO Home Manager imports here!
                                    ];
                                };
                            })
                    ];
                    inherit pkgs;
                };

                # Hiroshima, cheap laptop at home
#                hiroshima = nixpkgs.lib.nixosSystem {
#                    system = "x86_64-linux";
#                    modules = [
#                        defaults
#                        ./modules/common/fonts.nix
#                        ./modules/common/xserver.nix
#                        ./modules/hardware/libinput.nix
#                        ./modules/hardware/ssd.nix
#                        ./modules/hardware/tlp.nix
#                        # TODO: System packages here!
#                        (import ./hardware/hiroshima-hardware.nix)
#                        (import ./machines/hiroshima.nix)
#                        home-manager.nixosModules.home-manager
#                            ({
#                                home-manager.useGlobalPkgs = true;
#                                home-manager.useUserPackages = true;
#                                home-manager.users.romatthe = { ... }: {
#                                    imports = [
#                                        ./machines/hiroshima-home.nix
#                                        ./modules/terminal/alacritty.nix
#                                        # TODO Home Manager imports here!
#                                    ];
#                                };
#                            })
#                    ];
#                    inherit pkgs;
#                };

        };
    };
}
