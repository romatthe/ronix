{
  description = "Collection of my systems configured though Nix flakes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/master";
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
              inputs.nur.overlay 
            ]; 
          }

          (import ./hardware/yokohama-hardware.nix)
          (import ./machines/yokohama.nix)
          (import ./machines/yokohama-home.nix)
        ];
        specialArgs = { inherit inputs; };
      };
    };

    yokohama = self.nixosConfigurations.yokohama.config.system.build.toplevel;

  };
}
