{ config, lib, pkgs, ... }:

let
  cfg = config.programs.pangolin-cli;
in
{
  options.programs.pangolin-cli = {
    enable = lib.mkEnableOption "Pangolin CLI VPN client";

    package = lib.mkPackageOption pkgs "pangolin-cli" { };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };
}

