{
  description = "jnsgruk's nixos configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    vscode-server.url = "github:msteen/nixos-vscode-server";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, vscode-server }@inputs:
    let
      inherit (self) outputs;
      system = "x86_64-linux";
      forAllSystems = nixpkgs.lib.genAttrs [ "x86_64-linux" ];
    in
    {
      overlays = import ./overlays;

      packages = forAllSystems (system:
        import ./pkgs { pkgs = nixpkgs.legacyPackages.${system}; }
      );

      defaultPackage.x86_64-linux = home-manager.defaultPackage."x86_64-linux";

      homeConfigurations = {
        "jon@thor" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."x86_64-linux";
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ ./home/jon/thor.nix ];
        };
        "jon@odin" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."x86_64-linux";
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ ./home/jon/odin.nix ];
        };
      };

      nixosConfigurations = {
        thor = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [ ./hosts/thor ];
        };
        odin = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [ ./hosts/odin ];
        };
      };
    };
}
