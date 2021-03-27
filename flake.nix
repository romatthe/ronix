{
  description = "Collection of my systems configured though Nix flakes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/master";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... } @ inputs: {

    nixosConfigurations = {
      
      # Yokohama, home desktop workhorse
      yokohama = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ (import ./machines/yokohama.nix) ];
        specialArgs = { inherit inputs; };
      };

    };

    yokohama = self.nixosConfigurations.yokohama.config.system.build.toplevel;

  };
}
