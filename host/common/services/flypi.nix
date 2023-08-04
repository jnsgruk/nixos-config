{ inputs, pkgs, config, ... }: {
  imports = [
    inputs.flypi.nixosModules.dump1090
    inputs.flypi.nixosModules.fr24
    inputs.flypi.nixosModules.piaware
    inputs.flypi.nixosModules.planefinder
  ];

  services = {
    dump1090 = {
      enable = true;
      ui.enable = true;
    };
    fr24 = {
      enable = true;
      sharingKey = "ee582e60b377cbb4";
    };
    piaware = {
      enable = true;
      feederId = "9c8c4ac9-f7ad-4630-937b-7af0f49974f2";
    };
    planefinder = {
      enable = true;
      shareCode = "64cd2936680e6";
      latitude = "51.522";
      longitude = "-2.531";
    };
  };
}
