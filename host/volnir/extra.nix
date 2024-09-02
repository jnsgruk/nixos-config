{
  inputs,
  lib,
  pkgs,
  self,
  config,
  ...
}:
{
  imports = [
    "${self}/host/common/services/networkmanager.nix"
    inputs.flypi.nixosModules.dump1090
    inputs.flypi.nixosModules.planefinder
  ];

  age.secrets = {
    pfconfig = {
      file = "${self}/secrets/volnir-planefinder-config.age";
      owner = "root";
      group = "root";
      mode = "444";
    };
  };

  nixpkgs.overlays = [
    (_final: super: {
      makeModulesClosure = x: super.makeModulesClosure (x // { allowMissing = true; });
    })
  ];

  programs.firefox.enable = true;

  services = {
    cage = {
      enable = true;
      extraArguments = [ "-s" ];
      user = "jon";
      program = "${lib.getExe pkgs.firefox} -kiosk http://localhost:30053";
      environment = {
        WLR_LIBINPUT_NO_DEVICES = "1";
      };
    };

    chrony.extraConfig = ''
      makestep 1 -1
    '';

    dump1090.enable = true;

    kmscon.enable = lib.mkForce false;

    planefinder = {
      enable = true;
      openFirewall = true;
      configFile = config.age.secrets.pfconfig.path;
    };
  };
}
