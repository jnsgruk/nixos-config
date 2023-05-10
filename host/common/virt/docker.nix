{ pkgs, ... }: {
  virtualisation = {
    docker = {
      enable = true;
      storageDriver = "btrfs";
    };
  };

  environment.systemPackages = with pkgs; [
    ctop
    dive
    skopeo
  ];
}
