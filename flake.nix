{
  description = "jnsgruk's nixos configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    master.url = "github:nixos/nixpkgs/master";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";

    catppuccin.url = "github:catppuccin/nix";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    flypi.url = "github:jnsgruk/flypi";

    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    lanzaboote.url = "github:nix-community/lanzaboote";
    lanzaboote.inputs.nixpkgs.follows = "nixpkgs";

    libations.url = "github:jnsgruk/libations";
    libations.inputs.nixpkgs.follows = "nixpkgs";

    vscode-server.url = "github:nix-community/nixos-vscode-server";
    vscode-server.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      unstable,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      stateVersion = "24.11";
      username = "jon";

      libx = import ./lib {
        inherit
          self
          inputs
          outputs
          stateVersion
          username
          ;
      };
    in
    {
      # nix build .#homeConfigurations."jon@freyja".activationPackage
      homeConfigurations = {
        # Desktop machines
        "${username}@freyja" = libx.mkHome {
          hostname = "freyja";
          desktop = "hyprland";
        };
        "${username}@kara" = libx.mkHome {
          hostname = "kara";
          desktop = "hyprland";
        };
        # Headless machines
        "${username}@thor" = libx.mkHome { hostname = "thor"; };
        "${username}@volnir" = libx.mkHome {
          hostname = "volnir";
          system = "aarch64-linux";
        };
        "ubuntu@dev" = libx.mkHome {
          hostname = "dev";
          user = "ubuntu";
        };
      };

      # nix build .#nixosConfigurations.freyja.config.system.build.toplevel
      nixosConfigurations = {
        # Desktop machines
        freyja = libx.mkHost {
          hostname = "freyja";
          desktop = "hyprland";
        };
        kara = libx.mkHost {
          hostname = "kara";
          desktop = "hyprland";
        };
        # Headless machines
        thor = libx.mkHost {
          hostname = "thor";
        };
        volnir = libx.mkHost {
          hostname = "volnir";
        };
      };

      # Custom packages; acessible via 'nix build', 'nix shell', etc
      packages = libx.forAllSystems (
        system:
        let
          pkgs = unstable.legacyPackages.${system};
        in
        import ./pkgs { inherit pkgs; }
      );

      # Custom overlays
      overlays = import ./overlays { inherit inputs; };

      # Devshell for bootstrapping
      # Accessible via 'nix develop' or 'nix-shell' (legacy)
      devShells = libx.forAllSystems (
        system:
        let
          pkgs = unstable.legacyPackages.${system};
        in
        import ./shell.nix { inherit pkgs; }
      );

      formatter = libx.forAllSystems (system: self.packages.${system}.nixfmt-plus);
    };
}
