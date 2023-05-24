{ pkgs, ... }: {
  hardware.bluetooth = {
    enable = true;
    package = pkgs.bluezFull;
    settings = {
      General = {
        Experimental = true;
        KernelExperimental = true;
      };
    };
  };

  environment.systemPackages = with pkgs; [ blueberry ];
}
