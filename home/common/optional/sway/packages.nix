{ pkgs, ... }: {
  home.packages = with pkgs; [
    grim
    slurp
    swappy
    libva-utils
    wf-recorder
    wl-clipboard
    wdisplays
    wmctrl
  ];
}
