{ pkgs, config, ... }: {
  # Set up for https://www.files.gallery using NGINX Unit
  services.unit = {
    enable = true;
    group = "users";
    config = ''
      {
        "listeners": {
          "*:8081": {
            "application": "files-gallery"
          }
        },
        "applications": {
          "files-gallery": {
            "type": "php",
            "processes": 2,
            "root": "/data/apps/files",
          }
        }
      }
    '';
  };

  environment.systemPackages = with pkgs; [ ffmpeg ];
}
