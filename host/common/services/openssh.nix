{ options, ... }:
let
  # In later versions of NixOS, services.openssh.settings was introduced (23.05).
  # This allows this config to be used on machines running 23.05 and 22.11 without
  # showing deprecation warnings.
  #
  # Can be removed once all machines are nix >= 23.05.
  opensshAttrs =
    if (builtins.hasAttr "settings" options.services.openssh) then {
      # This is the newer way of doing things and should be collapsed into the
      # "services.openssh" block below.
      settings = {
        passwordAuthentication = false;
        permitRootLogin = "no";
      };
    } else {
      passwordAuthentication = false;
      permitRootLogin = "no";
    };
in
{
  services.openssh = {
    enable = true;
  } // opensshAttrs;

  programs.ssh.startAgent = true;
  networking.firewall.allowedTCPPorts = [ 22 ];
}
