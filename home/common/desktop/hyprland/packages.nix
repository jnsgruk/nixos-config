{ pkgs, ... }: {
  home.packages = with pkgs; [
    grim
    grimblast
    libva-utils
    playerctl
    slurp
    wdisplays
    wf-recorder
    wl-clipboard
    wmctrl
  ];
}
