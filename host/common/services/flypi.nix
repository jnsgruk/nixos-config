{ inputs, pkgs, config, ... }: {
  imports = [
    inputs.flypi.nixosModules.dump1090
    inputs.flypi.nixosModules.fr24
  ];

  services = {
    dump1090 = {
      enable = true;
    };
    fr24 = {
      enable = true;
    };
  };
}
