{ config, lib, pkgs, ... }:
with lib;
{
  options.modules = {
    git-daemon = {
      enable = mkEnableOption "Creates git server";
    };
  };

  config = mkIf config.modules.git-daemon.enable {
    environment.systemPackages = [ pkgs.git ];
    services = {
      gitDaemon = {
        enable = true;
        user = "git";
        group = "git";
        basePath = "/srv/git/";
        exportAll = true;
        port = 9418;
      };
      openssh.settings.PasswordAuthentication = false;
      sshguard.enable = true;
    };

    users.users.git = {
      isSystemUser = true;
      home = "/srv/git";
      createHome = true;
      shell = "${pkgs.git}/bin/git-shell";
      openssh.authorizedKeys.keyFiles = [
        ../keys/home-git.pub
      ];
    };
  };
}