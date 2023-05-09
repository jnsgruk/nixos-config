{
  description = "jnsgruk's nixos configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    vscode-server = {
      url = "github:msteen/nixos-vscode-server";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    crafts = {
      # url = "path:/home/jon/crafts-flake";
      url = "github:jnsgruk/crafts-flake";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    embr = {
      # url = "path:/home/jon/firecracker-ubuntu";
      url = "github:jnsgruk/firecracker-ubuntu";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs =
    { self
    , nixpkgs
    , nixpkgs-unstable
    , home-manager
    , ...
    } @ inputs:
    let
      inherit (self) outputs;

      forAllSystems = nixpkgs.lib.genAttrs [
        "aarch64-linux"
        "i686-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];

      # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
      stateVersion = "22.11";
    in
    {
      # Custom packages; acessible via 'nix build', 'nix shell', etc
      packages = forAllSystems (system:
        let pkgs = nixpkgs-unstable.legacyPackages.${system};
        in import ./pkgs { inherit pkgs; }
      );

      # Devshell for bootstrapping
      # Accessible via 'nix develop' or 'nix-shell' (legacy)
      devShells = forAllSystems (system:
        let pkgs = nixpkgs-unstable.legacyPackages.${system};
        in import ./shell.nix { inherit pkgs; }
      );

      formatter = forAllSystems (system:
        let pkgs = nixpkgs-unstable.legacyPackages.${system};
        in pkgs.nixpkgs-fmt
      );

      overlays = import ./overlays { inherit inputs; };

      homeConfigurations = {
        "jon@freyja" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs-unstable.legacyPackages.x86_64-linux;
          extraSpecialArgs = {
            inherit inputs outputs stateVersion;
            hostname = "freyja";
            desktop = "sway";
            username = "jon";
          };
          modules = [ ./home ];
        };

        "jon@loki" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs-unstable.legacyPackages.x86_64-linux;
          extraSpecialArgs = {
            inherit inputs outputs stateVersion;
            hostname = "loki";
            desktop = "sway";
            username = "jon";
          };
          modules = [ ./home ];
        };

        "jon@thor" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs-unstable.legacyPackages.x86_64-linux;
          extraSpecialArgs = {
            inherit inputs outputs stateVersion;
            hostname = "thor";
            desktop = null;
            username = "jon";
          };
          modules = [ ./home ];
        };

        # Used for running home-manager on Ubuntu under multipass
        "ubuntu@dev" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs-unstable.legacyPackages.x86_64-linux;
          extraSpecialArgs = {
            inherit inputs outputs stateVersion;
            hostname = "dev";
            desktop = null;
            username = "ubuntu";
          };
          modules = [ ./home ];
        };
      };

      # hostids are generated using `head -c4 /dev/urandom | od -A none -t x4`
      nixosConfigurations = {
        freyja = nixpkgs-unstable.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs stateVersion;
            hostname = "freyja";
            hostid = "c120a672";
            desktop = "sway";
            username = "jon";
          };
          modules = [ ./host ];
        };

        loki = nixpkgs-unstable.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs stateVersion;
            hostname = "loki";
            hostid = "4c53e052";
            desktop = "sway";
            username = "jon";
          };
          modules = [ ./host ];
        };

        thor = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs stateVersion;
            hostname = "thor";
            hostid = "96f2b9b5";
            desktop = null;
            username = "jon";
          };
          modules = [ ./host ];
        };
      };
    };
}
