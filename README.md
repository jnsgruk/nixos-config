# jnsgruk's nixos config

This repository contains a [Nix Flake](https://nixos.wiki/wiki/Flakes) for configuring my machines.

The machines configured thus far are:

| Hostname |      Model       |  Role  |
| :------: | :--------------: | :----: |
|  `odin`  | Dell XPS 13 9370 | Laptop |
|  `thor`  | Intel NUC6i7KYK  | Server |

## Structure

- [home]: my home-manager configuration
- [hosts]: host-specific configurations
- [overlays]: package/configuration overlays
- [pkgs]: my custom package definitions
- [scripts]: helper scripts for machine setup

[home]: ./home
[hosts]: ./hosts
[overlays]: ./overlays
[pkgs]: ./pkgs
[scripts]: ./scripts

## Applications / Packages

The following is a list of the key elements of my setup, with links to their config:

| Type  | Details                                               |
| :---: | :---------------------------------------------------- |
| Shell | [zsh], [starship], [nvim], [tmux], [neofetch]         |
|  WM   | [sway], [waybar], [swaylock], [mako], [greetd], [gtk] |
| Apps  | [vscode], [zathura], [alacritty]                      |

[alacritty]: ./home/jon/optional/desktop/alacritty.nix
[greetd]: ./home/jon/optional/sway/greetd.nix
[gtk]: ./home/jon/optional/desktop/gtk.nix
[mako]: ./home/jon/optional/sway/mako.nix
[neofetch]: ./home/jon/optional/desktop/neofetch/default.nix
[nvim]: ./home/common/vim/default.nix
[starship]: ./home/common/shell/starship.nix
[sway]: ./home/jon/optional/sway/default.nix
[swaylock]: ./home/jon/optional/sway/swaylock.nix
[tmux]: ./home/common/shell/tmux.nix
[vscode]: ./home/jon/optional/desktop/vscode.nix
[zathura]: ./home/jon/optional/desktop/zathura.nix
[waybar]: ./home/jon/optional/sway/waybar.nix
[zsh]: ./home/common/shell/zsh.nix

## Screenshots

![clean](.github/screenshots/screen_clean.png)
![neofetch](.github/screenshots/screen_neofetch.png)
![dirty](.github/screenshots/screen_dirty.png)
