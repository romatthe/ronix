{
  description = "Collection of my systems configured though Nix flakes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-20.09"
  };

  outputs = { self, nixpkgs, ... } @ inputs: {

    nixosConfigurations = {
      
      # Yokohama
      yokohama = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ (import ./machines/yokohama.nix) ];
        specialArgs = 
      };

    };

    yokohama = self.nixosConfigurations.yokohama.config.system.build.toplevel;

  };
}
