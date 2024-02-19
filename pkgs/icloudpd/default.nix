{ pkgs
, lib
, ...
}:
let
  pname = "icloudpd";
  version = "1.17.3";
in
pkgs.python3Packages.buildPythonApplication {
  inherit pname version;
  format = "pyproject";

  src = pkgs.fetchFromGitHub {
    owner = "icloud-photos-downloader";
    repo = "icloud_photos_downloader";
    rev = "refs/tags/v${version}";
    hash = "sha256-GS6GqlZfj5kfjKLImkOTDAgQDGJQHl74uTqbZHVpbac=";
  };

  patches = [
    ./deps.patch
  ];

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

  nativeCheckInputs = with pkgs.python3Packages; [
    freezegun
    mock
    pytestCheckHook
    vcrpy
  ];

  disabledTestPaths = [
    "tests/test_autodelete_photos.py"
  ];

  meta = {
    description = "A command-line tool to download photos from iCloud";
    homepage = "https://github.com/icloud-photos-downloader/icloud_photos_downloader";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ jnsgruk ];
  };
}
