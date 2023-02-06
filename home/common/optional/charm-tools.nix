{ pkgs
, inputs
, ...
}:
let
  crafts = inputs.crafts.packages."${pkgs.system}";
in
{
  home.packages = with crafts; [
    charmcraft
  ];
}
