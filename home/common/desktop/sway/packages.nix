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
  sway-clip = pkgs.writeShellScriptBin "sway-clip" ''
    export XDG_CACHE_HOME=/home/$USER/.local/cache
    cliphist list | rofi -dmenu -display-columns 2 -window-title '📋' | cliphist decode | wl-copy
  '';
in
{
  home.packages = with pkgs; [
    slurp
    sway-clip
    sway-screenshot
  ];
}
