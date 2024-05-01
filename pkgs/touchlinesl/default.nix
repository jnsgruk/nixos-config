{ lib, pkgs, ... }:
pkgs.buildHomeAssistantComponent rec {
  owner = "jnsgruk";
  domain = "touchlinesl";
  version = "0.0.1";

  src = lib.cleanSource ./src;
  # src = pkgs.fetchFromGitHub {
  #   inherit owner;
  #   repo = "ha_touchlinesl";
  #   rev = version;
  #   hash = "";
  # };

  propagatedBuildInputs = [ pkgs.python312Packages.aiohttp ];

  meta = with lib; {
    description = "A HomeAssistant integration for Roth Touchline SL heating controllers";
    homepage = "https://github.com/jnsgruk/touchlinesl-home-assistant";
    changelog = "https://github.com/jnsgruk/touchlinesl-home-assistant/releases/tag/${version}";
    maintainers = with maintainers; [ jnsgruk ];
    license = licenses.asl20;
  };
}
