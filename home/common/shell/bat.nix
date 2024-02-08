{ pkgs, ... }:
let
  theme = import ../../../lib/theme { inherit pkgs; };
  inherit (theme) batTheme;
in
{
  programs = {
    bat = {
      enable = true;
      themes = {
        "${batTheme.name}" = batTheme.theme;
      };
      config = { theme = batTheme.name; };
    };
  };
}
