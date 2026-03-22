{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    llm-agents = {
      url = "github:numtide/llm-agents.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-cli = {
      url = "github:nix-community/nixos-cli";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nur,
      llm-agents,
      nixos-cli,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      llm = llm-agents.packages.${system};
    in
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        modules = [
          ./configuration.nix
          nur.modules.nixos.default
          nixos-cli.nixosModules.nixos-cli
          (
            { pkgs, lib, ... }:
            {
              environment.systemPackages = [
                (import ./pkgs/cherry-studio.nix { inherit pkgs lib; })
                llm.opencode
                llm.claude-code
                llm.openclaw
                llm.claude-code-router
                llm.claude-plugins
                llm.ccstatusline
                llm.ccusage
                llm.ck
                llm.gno
                llm.qmd
              ];

              programs.nixos-cli = {
                enable = true;
                settings = {
                  # Default settings - customize as needed
                };
              };
            }
          )
        ];
      };
    };
}
