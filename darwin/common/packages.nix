{
  pkgs,
  lib,
  self,
  ...
}:
let
  inherit ((import "${self}/host/common/base/packages.nix" { inherit pkgs lib; })) basePackages;
in
{
  homebrew = {
    brews = [ ];
    casks = [
      "1password"
      "1password-cli"
      "bambu-studio"
      "bartender"
      "easy-move+resize"
      "iterm2"
      "google-chrome"
      "obsidian"
      "rambox"
      "raycast"
      "signal"
      "soundsource"
      "sublime-merge"
      "tailscale"
      "todoist"
      "visual-studio-code"
      "vlc"
      "zen-browser"
      "zoom"
    ];
    masApps = { };
    taps = [ ];
  };

  environment.systemPackages =
    basePackages
    ++ (with pkgs; [
      coreutils-full
      gnugrep
      gnused
      m-cli
      mas
      plistwatch
      yubikey-manager
    ]);
}
