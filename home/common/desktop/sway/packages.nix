{ pkgs, ... }:
let
  sway-screenshot = pkgs.writeShellScriptBin "sway-screenshot" ''
    if [[ "$1" == "screen" ]]; then
      grim -o $(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name') - | swappy -f -
    elif [[ "$1" == "window" ]]; then
      grim -g "$(swaymsg -t get_tree | jq -r '.. | select(.pid? and .visible?) | .rect | "\(.x),\(.y) \(.width)x\(.height)"' | slurp)" - | swappy -f -
    elif [[ "$1" == "region" ]]; then
      grim -g "$(slurp)" - | swappy -f -
    fi
  '';
in
{
  home.packages = with pkgs; [
    grim
    swappy
    libva-utils
    slurp
    sway-screenshot
    wf-recorder
    wl-clipboard
    wdisplays
    wmctrl
  ];

  home.file = {
    ".config/swappy/config".text = ''
      [Default]
      save_dir=$HOME/pictures/screenshots
      save_filename_format=screenshot-%Y%m%d-%H%M%S.png
      early_exit=true
    '';
  };
}
