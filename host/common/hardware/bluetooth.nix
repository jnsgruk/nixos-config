{ pkgs, desktop, ... }:
{
  hardware.bluetooth = {
    enable = true;
    package = pkgs.bluez;
    settings = {
      General = {
        Experimental = true;
        KernelExperimental = true;
      };
    };
  };

  environment.systemPackages = if (builtins.isString desktop) then [ pkgs.blueberry ] else [ ];
}
