{ pkgs
, ...
}:
let
  name = "scrutiny";
  version = "0.7.2";
in
{
  inherit name version;

  repo = pkgs.fetchFromGitHub {
    owner = "AnalogJ";
    repo = name;
    rev = "v${version}";
    sha256 = "sha256-UYKi+WTsasUaE6irzMAHr66k7wXyec8FXc8AWjEk0qs=";
  };

  vendorHash = "sha256-SiQw6pq0Fyy8Ia39S/Vgp9Mlfog2drtVn43g+GXiQuI=";
}
