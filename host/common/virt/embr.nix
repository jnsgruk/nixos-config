{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ embr ];

  networking = {
    firewall = {
      # Allow traffic from any embr managed interface
      trustedInterfaces = [ "embr+" ];
    };
  };
}
