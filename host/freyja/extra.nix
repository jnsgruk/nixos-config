{ lib, pkgs, ... }:
{
  imports = [ ../common/services/networkmanager.nix ];

  services.tlp.enable = lib.mkForce false;

  services.pipewire.wireplumber.configPackages = [
    (pkgs.writeTextDir "share/wireplumber/wireplumber.conf.d/99-disable-alsa-ucm.conf" ''
      monitor.alsa.rules = [
        {
          matches = [
            { node.name = "~alsa_input.*" }
            { node.name = "~alsa_output.*" }
          ]
          actions = {
            update-props = {
              api.alsa.use-ucm = false
            }
          }
        }
      ]
    '')
  ];
}
