_: {
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "both";
    openFirewall = true;
  };

  networking.firewall.trustedInterfaces = [ "tailscale0" ];
}
