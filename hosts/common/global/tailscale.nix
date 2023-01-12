{
  pkgs,
  config,
  ...
}: let
  secrets = (import ../../../secrets.nix)."${config.networking.hostName}";
in {
  services.tailscale.enable = true;

  networking = {
    firewall = {
      checkReversePath = "loose";
      allowedUDPPorts = [config.services.tailscale.port];
      trustedInterfaces = ["tailscale0"];
    };
  };

  systemd.services = {
    tailscale-autoconnect = {
      description = "Automatic connection to Tailscale";
      after = ["network-pre.target" "tailscale.service"];
      wants = ["network-pre.target" "tailscale.service"];
      wantedBy = ["multi-user.target"];

      serviceConfig.Type = "oneshot";
      script = with pkgs; ''
        # wait for tailscaled to settle
        sleep 2
        # check if we are already authenticated to tailscale
        status="$(${tailscale}/bin/tailscale status -json | ${jq}/bin/jq -r .BackendState)"
        if [ $status = "Running" ]; then # if so, then do nothing
        exit 0
        fi
        # otherwise authenticate with tailscale
        ${tailscale}/bin/tailscale up -authkey ${secrets.tailscale}
      '';
    };
  };
}
