{ pkgs, ... }:
let
  python-packages = p: with p; [
    tox
    black
    virtualenv
    requests
  ];
  python = pkgs.python3.withPackages python-packages;
in
{
  home.packages = with pkgs; [
    ruff
    python
  ];
}
