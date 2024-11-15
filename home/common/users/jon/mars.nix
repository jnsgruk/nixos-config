{ self, ... }:
{
  imports = [
    "${self}/home/common/desktop/alacritty.nix"
    "${self}/home/common/dev/base.nix"
  ];

  services = {
    syncthing = {
      enable = true;
      extraOptions = [
        "-gui-address=mars.tailnet-d5da.ts.net:8384"
        "-home=/Users/jon/.syncthing"
      ];
    };
  };

  programs.zsh.sessionVariables = {
    SSH_AUTH_SOCK = "/Users/jon/.ssh/agent";
  };
}
