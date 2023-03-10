{
  description = "jnsgruk's nixos configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    vscode-server.url = "github:msteen/nixos-vscode-server";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    crafts = {
      # url = "path:/home/jon/crafts-flake";
      url = "github:jnsgruk/crafts-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    embr = {
      # url = "path:/home/jon/firecracker-ubuntu";
      url = "github:jnsgruk/firecracker-ubuntu";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self
    , nixpkgs
    , home-manager
    , ...
    } @ inputs:
    let
      inherit (self) outputs;
      system = "x86_64-linux";
    in
    {
      defaultPackage.x86_64-linux = home-manager.defaultPackage."x86_64-linux";

      overlays = import ./overlays;

      homeConfigurations = {
        "jon@loki" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          extraSpecialArgs = {
            inherit inputs outputs;
            hostname = "loki";
            type = "desktop";
          };
          modules = [ ./home/jon/loki.nix ];
        };
        "jon@thor" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          extraSpecialArgs = {
            inherit inputs outputs;
            hostname = "thor";
            type = "headless";
          };
          modules = [ ./home/jon/thor.nix ];
        };
        "jon@odin" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          extraSpecialArgs = {
            inherit inputs outputs;
            hostname = "odin";
            type = "laptop";
          };
          modules = [ ./home/jon/odin.nix ];
        };
      };

      nixosConfigurations = {
        loki = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs outputs; };
          modules = [
            ./hosts/loki
          ];
        };
        thor = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs outputs; };
          modules = [
            ./hosts/thor
          ];
        };
        odin = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs outputs; };
          modules = [
            ./hosts/odin
          ];
        };
      };
    };
}
