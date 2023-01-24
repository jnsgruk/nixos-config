{
  pkgs,
  inputs,
  ...
}: let
  embr = inputs.embr.packages."${pkgs.system}".embr;
in {
  environment.systemPackages = [embr];

  networking = {
    firewall = {
      # Allow traffic from any embr managed interface
      trustedInterfaces = ["embr+"];
    };
  };
}
