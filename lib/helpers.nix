{ inputs, outputs, stateVersion, theme, username, ... }: {
  # Helper function for generating home-manager configs
  mkHome = { hostname, user ? username, desktop ? null }: inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = inputs.nixpkgs-unstable.legacyPackages.x86_64-linux;
    extraSpecialArgs = {
      inherit inputs outputs stateVersion theme hostname desktop;
      username = user;
    };
    modules = [ ../home ];
  };

  # Helper function for generating host configs
  mkHost = { hostname, desktop ? null, pkgsInput ? inputs.nixpkgs-unstable }: pkgsInput.lib.nixosSystem {
    specialArgs = {
      inherit inputs outputs stateVersion theme username hostname desktop;
    };
    modules = [ ../host ];
  };

  forAllSystems = inputs.nixpkgs.lib.genAttrs [
    "aarch64-linux"
    "i686-linux"
    "x86_64-linux"
    "aarch64-darwin"
    "x86_64-darwin"
  ];
}
