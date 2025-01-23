{ pkgs, ... }:
{
  programs.atuin = {
    enable = true;
    enableFishIntegration = true;
    package = pkgs.atuin;
    flags = [ "--disable-up-arrow" ];
    settings = {
      enter_accept = false;
      dialect = "uk";
      dotfiles = {
        enabled = false;
      };
      sync = {
        records = true;
      };
    };
  };
}
