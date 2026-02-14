{
  description = "Pangolin CLI tool and VPN client";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      pkgsFor = system: nixpkgs.legacyPackages.${system};
    in
    {
      packages = forAllSystems (system:
        let
          pkgs = pkgsFor system;
        in
        rec {
          pangolin-cli = pkgs.callPackage ./pkgs/pangolin-cli.nix { };
          default = pangolin-cli;
        }
      );

      nixosModules = {
        pangolin-cli = import ./modules/pangolin-cli.nix;
        default = self.nixosModules.pangolin-cli;
      };

      homeManagerModules = {
        pangolin-cli = import ./modules/home-manager.nix;
        default = self.homeManagerModules.pangolin-cli;
      };

      overlays.default = final: prev: {
        pangolin-cli = final.callPackage ./pkgs/pangolin-cli.nix { };
      };
    };
}

