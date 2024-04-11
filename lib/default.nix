{
  self,
  inputs,
  outputs,
  stateVersion,
  username,
  ...
}:
let
  helpers = import ./helpers.nix {
    inherit
      self
      inputs
      outputs
      stateVersion
      username
      ;
  };
in
{
  inherit (helpers) mkHome mkHost forAllSystems;
}
