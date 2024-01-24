{
  description = "jnsgruk's nixos configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "unstable";

    nix-formatter-pack.url = "github:Gerschtli/nix-formatter-pack";
    nix-formatter-pack.inputs.nixpkgs.follows = "unstable";

    hyprland.url = "github:hyprwm/Hyprland";
    hyprland.inputs.nixpkgs.follows = "unstable";
    hyprland-contrib.url = "github:hyprwm/contrib";
    hyprland-contrib.inputs.nixpkgs.follows = "unstable";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "unstable";

    lanzaboote.url = "github:nix-community/lanzaboote";
    lanzaboote.inputs.nixpkgs.follows = "unstable";

    vscode-server.url = "github:nix-community/nixos-vscode-server";
    vscode-server.inputs.nixpkgs.follows = "unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "unstable";

    crafts.url = "github:jnsgruk/crafts-flake"; # url = "path:/home/jon/crafts-flake";
    crafts.inputs.nixpkgs.follows = "unstable";
    embr.url = "github:jnsgruk/firecracker-ubuntu";
    embr.inputs.nixpkgs.follows = "unstable";
    libations.url = "github:jnsgruk/libations";
    libations.inputs.nixpkgs.follows = "unstable";
  };

  outputs =
    { self
    , nixpkgs
    , unstable
    , nix-formatter-pack
    , ...
    } @ inputs:
    let
      inherit (self) outputs;
      stateVersion = "23.11";
      username = "jon";

      libx = import ./lib { inherit inputs outputs stateVersion username; };
    in
    {
      # nix build .#homeConfigurations."jon@freyja".activationPackage
      homeConfigurations = {
        # Desktop machines
        "${username}@freyja" = libx.mkHome { hostname = "freyja"; desktop = "hyprland"; };
        "${username}@kara" = libx.mkHome { hostname = "kara"; desktop = "hyprland"; };
        # Headless machines
        "${username}@hugin" = libx.mkHome { hostname = "hugin"; };
        "${username}@thor" = libx.mkHome { hostname = "thor"; };
        "ubuntu@dev" = libx.mkHome { hostname = "dev"; user = "ubuntu"; };
      };

      # nix build .#nixosConfigurations.freyja.config.system.build.toplevel
      nixosConfigurations = {
        # Desktop machines
        freyja = libx.mkHost { hostname = "freyja"; desktop = "hyprland"; };
        kara = libx.mkHost { hostname = "kara"; desktop = "hyprland"; };
        # Headless machines
        hugin = libx.mkHost { hostname = "hugin"; pkgsInput = nixpkgs; };
        thor = libx.mkHost { hostname = "thor"; pkgsInput = nixpkgs; };
      };

      # Custom packages; acessible via 'nix build', 'nix shell', etc
      packages = libx.forAllSystems (system:
        let pkgs = unstable.legacyPackages.${system};
        in import ./pkgs { inherit pkgs; }
      );

      # Custom overlays
      overlays = import ./overlays { inherit inputs; };

      # Devshell for bootstrapping
      # Accessible via 'nix develop' or 'nix-shell' (legacy)
      devShells = libx.forAllSystems (system:
        let pkgs = unstable.legacyPackages.${system};
        in import ./shell.nix { inherit pkgs; }
      );

      formatter = libx.forAllSystems (system:
        nix-formatter-pack.lib.mkFormatter {
          pkgs = unstable.legacyPackages.${system};
          config.tools = {
            deadnix.enable = true;
            nixpkgs-fmt.enable = true;
            statix.enable = true;
          };
        }
      );

      nixConfig = {
        substituters = [
          "https://cache.nixos.org"
          "https://hyprland.cachix.org"
          "https://jnsgruk.cachix.org"
        ];
        trusted-public-keys = [
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
          "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
          "jnsgruk.cachix.org-1:Kf9JahXxCf0ElU+Uz7xKvQEQHfUtg2Z45N2NeTxuxV8="
        ];
      };
    };
}
