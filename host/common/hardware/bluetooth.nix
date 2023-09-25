{ pkgs, ... }: {
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

  environment.systemPackages = with pkgs; [ blueberry ];
}
