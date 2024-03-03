{ config, lib, pkgs, ... }:

{
  environment.systemPackages = [ pkgs.git ];
  services = {
    gitDaemon = {
      enable = true;
      basePath = "/srv/git/";
      exportAll = true;
      port = 22;
    };
    #openssh.passwordAuthentication = false;
    sshguard.enable = true;
  };

  users.users.git = {
    isSystemUser = true;
    home = "/srv/git";
    shell = "${pkgs.git}/bin/git-shell";
    # Defining authorized keys here will disable ssh-copy-id
    /* openssh.authorizedKeys.keys = [
      #"ssh-ed 25519 ...."
    ]; */
  };
}