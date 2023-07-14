{ inputs, outputs, stateVersion, username, ... }:
let
  theme = import ./theme { inherit outputs inputs; };
  helpers = import ./helpers.nix { inherit inputs outputs stateVersion theme username; };
in
{
  inherit theme;
  inherit (helpers) mkHome mkHost forAllSystems;
}
