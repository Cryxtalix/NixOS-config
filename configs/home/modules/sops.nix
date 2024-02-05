{ config, pkgs, username, ... }:

{
  sops = {
    age.keyFile = "/home/${username}/.config/sops/age/keys.txt";
    defaultSopsFile = ../../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";

    defaultSymlinkPath = "/run/user/1000/secrets";
    defaultSecretsMountPoint = "/run/user/1000/secrets.d";

    #secrets.example_key = {};
    # cat /run/user/1000/secrets/example_key
  };
  # systemd.user.services.my_service.Unit.After = [ "sops-nix.service" ];
  # Starts my_service only after sops-nix.service
}