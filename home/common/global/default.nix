{ outputs, ... }: {
  imports = [
    ./shell
    ./vim
    ./git.nix
  ];

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfreePredicate = _: true;
      permittedInsecurePackages = [
        "electron-18.1.0"
      ];
    };
  };

  home = {
    username = "jon";
    homeDirectory = "/home/jon";
    stateVersion = "22.11";
  };

  programs.home-manager.enable = true;

  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    pinentryFlavor = "qt";
  };

  fonts.fontconfig.enable = true;
}
