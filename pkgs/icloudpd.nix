{ pkgs
, lib
, ...
}:
let
  pname = "icloudpd";
  version = "1.16.0";
in
pkgs.python3Packages.buildPythonApplication {
  inherit pname version;
  format = "pyproject";

  src = pkgs.fetchFromGitHub {
    owner = "icloud-photos-downloader";
    repo = "icloud_photos_downloader";
    rev = "v${version}";
    hash = "sha256-G92NPS0rZ+IqCIOZkhT0KyhkoOuUreBxX21d/0hNiGw=";
  };

  postPatch = ''
    substituteInPlace pyproject.toml \
      --replace "wheel>=0.40.0,<0.41" "wheel" \
      --replace "pytz>=2022.7.1,<2023" "pytz"
  '';

  buildInputs = with pkgs; [ git ];

  propagatedBuildInputs = with pkgs.python3Packages; [
    certifi
    click
    future
    keyring
    keyrings-alt
    piexif
    python-dateutil
    pytz
    requests
    schema
    setuptools
    six
    tqdm
    tzlocal
    urllib3
    wheel
  ];

  # TODO: Try to make the tests pass and remove this.
  doCheck = false;

  meta = {
    description = "A command-line tool to download photos from iCloud";
    homepage = "https://github.com/icloud-photos-downloader/icloud_photos_downloader";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ jnsgruk ];
  };
}
