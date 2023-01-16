{pkgs, ...}: {
  home.packages = with pkgs; [
    avizo
    brightnessctl
    clipman
    grim
    playerctl
    sway-scripts
    slurp
    swappy
    swaybg
    swayidle
    swaylock-effects
    pamixer
    pavucontrol
    ulauncher
    wf-recorder
    wl-clipboard
    wlsunset
    wmctrl
    wofi
  ];
}
