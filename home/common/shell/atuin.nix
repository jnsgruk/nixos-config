{ pkgs, ... }:
{
  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    package = pkgs.atuin;
    flags = [ "--disable-up-arrow" ];
    settings = {
      enter_accept = false;
      dialect = "uk";
      dotfiles = {
        enabled = false;
      };
    };
  };
}
