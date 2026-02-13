{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule rec {
  pname = "pangolin-cli";
  version = "0.3.3";

  src = fetchFromGitHub {
    owner = "fosrl";
    repo = "cli";
    rev = version;
    hash = "sha256-VOb/rmfeJ51MaI37v9+wEDuSmPQyOuKqfGKxY7gtl1c=";
  };

  vendorHash = "sha256-hZj/PDNsWGplSrOgzJtL09/oFXHZ4zdS7BiRS+oy5bw=";

  ldflags = [
    "-s"
    "-w"
  ];

  meta = with lib; {
    description = "Pangolin CLI tool and VPN client";
    homepage = "https://github.com/fosrl/cli";
    license = licenses.unfree;
    maintainers = [ ];
    mainProgram = "cli";
  };
}

