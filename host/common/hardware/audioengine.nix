{ pkgs, ... }: {
  services.pipewire.wireplumber.configPackages = [
    (pkgs.writeTextDir "share/wireplumber/main.lua.d/51-disable-suspension.lua" ''
      table.insert (alsa_monitor.rules, {
        matches = {
          {
            { "node.nick", "matches", "Audioengine 2+" },
          },
        },
        apply_properties = {
          ["session.suspend-timeout-seconds"] = 0,
        },
      })
    '')
  ];
}
