{ pkgs, ... }: {
  home.packages = with pkgs; [
    grim
    slurp
    swappy
    wf-recorder
    wmctrl
  ];
}
