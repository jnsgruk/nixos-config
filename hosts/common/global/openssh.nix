{...}: {
  services.openssh = {
    enable = true;
    passwordAuthentication = false;
    permitRootLogin = "no";
  };

  programs.ssh.startAgent = true;

  networking.firewall.allowedTCPPorts = [22];
}
