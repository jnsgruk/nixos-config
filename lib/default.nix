{ inputs, outputs, stateVersion, username, ... }:
let
  theme = import ./theme { inherit outputs inputs; };
  helpers = import ./helpers.nix { inherit inputs outputs stateVersion theme username; };
in
{
  inherit theme;
  mkHome = helpers.mkHome;
  mkHost = helpers.mkHost;
  forAllSystems = helpers.forAllSystems;
}
