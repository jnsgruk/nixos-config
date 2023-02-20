# jnsgruk's nixos config

This repository contains a [Nix Flake](https://nixos.wiki/wiki/Flakes) for configuring my machines.

The machines configured thus far are:

| Hostname |       Model        |  Role   |
| :------: | :----------------: | :-----: |
|  `loki`  | Ryzen 3900X Custom | Desktop |
|  `odin`  |  Dell XPS 13 9370  | Laptop  |
|  `thor`  |  Intel NUC6i7KYK   | Server  |

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

[alacritty]: ./home/common/optional/desktop/alacritty.nix
[greetd]: ./hosts/common/optional/greetd.nix
[gtk]: ./home/common/optional/desktop/gtk.nix
[mako]: ./home/common/optional/sway/mako.nix
[neofetch]: ./home/common/optional/desktop/neofetch/default.nix
[nvim]: ./home/common/global/vim/default.nix
[starship]: ./home/common/global/shell/starship.nix
[sway]: ./home/common/optional/sway/default.nix
[swaylock]: ./home/common/optional/sway/swaylock.nix
[tmux]: ./home/common/global/shell/tmux.nix
[vscode]: ./home/common/optional/desktop/vscode.nix
[zathura]: ./home/common/optional/desktop/zathura.nix
[waybar]: ./home/common/optional/sway/waybar.nix
[zsh]: ./home/common/global/shell/zsh.nix

## Screenshots

![clean](.github/screenshots/screen_clean.png)
![neofetch](.github/screenshots/screen_neofetch.png)
![dirty](.github/screenshots/screen_dirty.png)
