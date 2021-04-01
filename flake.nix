{
  description = "Collection of my systems configured though Nix flakes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/master";
    nixpkgs-extra = {
      url = "github:romatthe/nixpkgs-extra";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
    emacs.url = "github:nix-community/emacs-overlay";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, nur, ... } @ inputs: {

    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;

    nixosConfigurations = {
      
      # Yokohama, home desktop workhorse
      yokohama = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          inputs.home-manager.nixosModules.home-manager 
          
          { nixpkgs.overlays = [ 
              inputs.emacs.overlay
              inputs.nixpkgs-extra.overlay
              inputs.nur.overlay 
            ]; 
          }

          (import ./hardware/yokohama-hardware.nix)
          (import ./machines/yokohama.nix)
        ];
        specialArgs = { inherit inputs; };
      };

      # Hiroshima, cheap laptop at home
      hiroshima = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          inputs.home-manager.nixosModules.home-manager 
          
          { nixpkgs.overlays = [ 
              inputs.emacs.overlay
              inputs.nixpkgs-extra.overlay
              inputs.nur.overlay 
            ]; 
          }

          (import ./hardware/hiroshima-hardware.nix)
          (import ./machines/hiroshima.nix)
        ];
        specialArgs = { inherit inputs; };
      };
    };

    yokohama = self.nixosConfigurations.yokohama.config.system.build.toplevel;
    hiroshima = self.nixosConfigurations.hiroshima.config.system.build.toplevel;

  };
}
