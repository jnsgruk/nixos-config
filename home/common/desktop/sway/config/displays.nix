{ wallpaper, ... }:
{
  kara = {
    "DP-1" = {
      mode = "7680x2160@119.997Hz";
      bg = "${wallpaper} fill";
    };
  };

  freyja = {
    "eDP-1" = {
      mode = "2880x1800@60Hz";
      scale = 1.5;
      bg = "${wallpaper} fill";
    };
  };
}
