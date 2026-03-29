{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule rec {
  pname = "pangolin-cli";
  version = "0.5.3";

  src = fetchFromGitHub {
    owner = "fosrl";
    repo = "cli";
    rev = version;
    hash = "sha256-ZgdYc7DbNdxwNxPswSRgmuZ4czqL+IfZAjo4XH2Df2I=";
  };

  vendorHash = "sha256-eBrglhyqKy6pG9eF0yfJdCOLxeWys4atKAp9Jgtzdj8=";

  subPackages = [ "." ];

  ldflags = [
    "-s"
    "-w"
  ];

  postFixup = ''
    ls $out/bin
    mv $out/bin/cli $out/bin/pangolin
  '';

  meta = with lib; {
    description = "Pangolin CLI tool and VPN client";
    homepage = "https://github.com/fosrl/cli";
    license = licenses.unfree;
    maintainers = [ ];
    mainProgram = "cli";
  };
}

