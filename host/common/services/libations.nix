{ config, pkgs, ... }:
let
  # Fetch the libations recipes from a private repository. Note that there must be a
  # valid SSH key either in the agent of the user executing the `nix` command, or in
  # `/root/.ssh` or this will fail.
  recipes = builtins.fetchGit {
    url = "git@github.com:jnsgruk/libations-recipes";
    rev = "74096c18056bc7ec6bd1cc7b8f3e28503eaddb64";
  };

  libations = pkgs.buildGoModule {
    pname = "libations";
    version = "unstable-2023-12-15";
    src = pkgs.fetchFromGitHub {
      owner = "jnsgruk";
      repo = "libations";
      rev = "694058b921efe9227018cec46bbd51c808dbc81b";
      hash = "sha256-sjh/99vxszaFDwltzU5ReF2Oqdzx0Qx0KC+lMgu15lk=";
    };
    vendorHash = "sha256-Ep3nBl9WZm7skk1cmMS9KI019ZSRSxofbLs2Nrj6HM8=";
    nativeBuildInputs = with pkgs; [ hugo ];
    postConfigure = ''
      # Patch the recipes that were fetched above into the app before building
      cp ${recipes}/recipes.json ./webui/data/drinks.json
      # Generate the Hugo site that's embedded in the app
      go generate
    '';
  };
in
{
  age.secrets = {
    libations-auth-key = {
      file = ../../../secrets/thor-libations-tskey.age;
      owner = "root";
      group = "root";
      mode = "400";
    };
  };

  services.libations = {
    enable = true;
    package = libations;
    tailscaleKeyFile = config.age.secrets.libations-auth-key.path;
  };
}

