{ pkgs, ... }: {
  home.packages = with pkgs; [
    grim
    grimblast
    slurp
    libva-utils
    wf-recorder
    wl-clipboard
    wdisplays
    wmctrl
  ];
}
