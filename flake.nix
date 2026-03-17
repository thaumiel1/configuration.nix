{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs"; # avoids a second copy of nixpkgs
    };
  };

  outputs = { self, nixpkgs, nur, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      modules = [
        ./configuration.nix
        nur.modules.nixos.default  # adds the NUR overlay to your system
      ];
    };
  };
}
