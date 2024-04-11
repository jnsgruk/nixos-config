# Shell for bootstrapping flake-enabled nix and home-manager
# Access development shell with  'nix develop' or (legacy) 'nix-shell'
{
  pkgs ? (import ./nixpkgs.nix) { },
}:
{
  default = pkgs.mkShell {
    name = "jnsgruk-flake";
    # Enable experimental features without having to specify the argument
    NIX_CONFIG = "experimental-features = nix-command flakes";
    nativeBuildInputs = with pkgs; [
      nix
      home-manager
      git
    ];
    shellHook = ''
      exec zsh
    '';
  };
}
