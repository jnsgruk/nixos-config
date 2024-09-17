{ pkgs, ... }:
{
  imports = [
    ../common/services/backup
  ];

  services.pipewire.wireplumber.configPackages = [
    (pkgs.writeTextDir "share/wireplumber/wireplumber.conf.d/99-disable-idle-timeout.conf" ''
      monitor.alsa.rules = [
        {
          matches = [
            { node.name = "~alsa_input.*" }
            { node.name = "~alsa_output.*" }
          ]
          actions = {
            update-props = {
              session.suspend-timeout-seconds = 0,
            }
          }
        }
      ]
    '')
  ];
}
