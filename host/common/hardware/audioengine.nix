_: {
  environment.etc = {
    "wireplumber/main.lua.d/51-disable-suspension.lua".text = ''
      table.insert (alsa_monitor.rules, {
        matches = {
          {
            { "node.name", "matches", "*Audioengine*" },
          },
        },
        apply_properties = {
          ["session.suspend-timeout-seconds"] = 0,
        },
      })
    '';
  };
}
