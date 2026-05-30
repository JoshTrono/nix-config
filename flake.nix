{
  description = "Your new nix config (flake-parts version)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, nixos-hardware, nix-flatpak, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {


      # perSystem = { pkgs, system, ... }: {
      #   packages = import ./pkgs pkgs;
      #   formatter = pkgs.alejandra;
      # };
      systems = [
        "x86_64-linux"
      ];
      imports = [
        
      ];

      flake = {
        overlays = import ./overlays { inherit inputs; };
        nixosModules = import ./modules/nixos;
        homeManagerModules = import ./modules/home-manager;

        nixosConfigurations = {
          Zeus = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = { inherit inputs; };
            modules = [
              nix-flatpak.nixosModules.nix-flatpak
              nixos-hardware.nixosModules.framework-16-amd-ai-300-series
              ./nixos/configuration.nix
              
            ];
          };
          server = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = { inherit inputs; };
            modules = [
              nix-flatpak.nixosModules.nix-flatpak
              nixos-hardware.nixosModules.framework-16-amd-ai-300-series
              ./nixos/server/configuration.nix
              
            ];
          };
        };

        homeConfigurations = {
          "joshua@Zeus" = home-manager.lib.homeManagerConfiguration {
            pkgs = nixpkgs.legacyPackages.x86_64-linux;
            extraSpecialArgs = { inherit inputs; };
            modules = [
              ./home-manager/home.nix
            ];
          };
        };
      };
    };
}
