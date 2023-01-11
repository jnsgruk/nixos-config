{ ... }: {
  services.openssh = {
    enable = true;
    passwordAuthentication = false;
    permitRootLogin = "no";
  };

  networking.firewall.allowedTCPPorts = [ 22 ];
}
