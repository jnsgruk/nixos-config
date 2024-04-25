{ pkgs, ... }:
{
  services.home-assistant = {
    enable = true;
    openFirewall = true;
    extraComponents = [
      "apple_tv"
      "brother"
      "default_config"
      "icloud"
      "ipp"
      "jellyfin"
      "met"
      "otbr"
      "ring"
      "radarr"
      "roomba"
      "snmp"
      "sonarr"
      "sonos"
      "unifi"
      "unifiprotect"
      "upnp"
      "webostv"
    ];
    customComponents = [
      (pkgs.buildHomeAssistantComponent rec {
        owner = "hultenvp";
        domain = "solis";
        version = "3.5.2";

        src = pkgs.fetchFromGitHub {
          owner = "hultenvp";
          repo = "solis-sensor";
          rev = "v${version}";
          sha256 = "sha256-Dibn8WTFFnyZnoXYUJ+ZmHBKhBRbWil3eMFUebWckQA=";
        };
      })
    ];
    config = {
      default_config = { };
    };
  };
}
