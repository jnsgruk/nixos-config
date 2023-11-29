{ inputs, pkgs, ... }: {
  disabledModules = [ "${inputs.nixpkgs}/nixos/modules/services/misc/homepage-dashboard.nix" ];
  imports = [ "${inputs.unstable}/nixos/modules/services/misc/homepage-dashboard.nix" ];

  services.homepage-dashboard = {
    enable = true;
    package = pkgs.unstable.homepage-dashboard;
    openFirewall = true;
  };
}
