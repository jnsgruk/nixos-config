{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [ fastfetch ];

    file = {
      ".config/fastfetch/config.jsonc".text = builtins.readFile ./fastfetch.jsonc;
    };
  };
}
