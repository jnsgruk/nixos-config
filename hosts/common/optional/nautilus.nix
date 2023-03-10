{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    gnome.nautilus
  ];

  programs = {
    # Archive manager
    file-roller.enable = true;
  };

  services = {
    gvfs.enable = true;
    # Enable quick preview with sushi
    gnome.sushi.enable = true;
  };
}
