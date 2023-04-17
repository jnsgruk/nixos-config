{ pkgs
, inputs
, ...
}:
let
  crafts = inputs.crafts.packages."${pkgs.system}";
in
{
  home.packages = (with pkgs; [
    juju
  ]) ++ (with crafts; [
    charmcraft
  ]);
}
