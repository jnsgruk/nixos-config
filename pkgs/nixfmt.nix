{ pkgs
, ...
}:

pkgs.writeShellApplication {
  name = "nixfmt";
  runtimeInputs = with pkgs; [
    deadnix
    nixpkgs-fmt
    statix
  ];
  text = ''
    set -x
    deadnix --edit
    statix fix
    nixpkgs-fmt .
  '';
}
