{ pkgs, ... }:
let
  build-all = pkgs.writeShellApplication {
    name = "build-all";
    runtimeInputs = with pkgs; [
      coreutils-full
    ];
    text = builtins.readFile ./build-all.sh;
  };

  build-host = pkgs.writeShellApplication {
    name = "build-host";
    runtimeInputs = with pkgs; [
      bc
      coreutils-full
      nix-output-monitor
    ];
    text = builtins.readFile ./build-host.sh;
  };

  install-homebrew = pkgs.writeShellApplication {
    name = "install-homebrew";
    runtimeInputs = with pkgs; [
      curl
    ];
    text = builtins.readFile ./install-homebrew.sh;
  };

  switch-all = pkgs.writeShellApplication {
    name = "switch-all";
    runtimeInputs = with pkgs; [
      coreutils-full
    ];
    text = builtins.readFile ./switch-all.sh;
  };

  switch-host = pkgs.writeShellApplication {
    name = "switch-host";
    runtimeInputs = with pkgs; [
      bc
      coreutils-full
    ];
    text = builtins.readFile ./switch-host.sh;
  };
in
{
  environment.systemPackages = [
    build-all
    build-host
    install-homebrew
    switch-all
    switch-host
  ];
}
