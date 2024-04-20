{ ... }:
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
    config = {
      default_config = { };
    };
  };
}
