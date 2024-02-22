{ config, pkgs, username, ... }:

{
  sops = {
    age.keyFile = "/home/${username}/.config/sops/age/keys.txt";
    defaultSopsFile = ../../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
      
    secrets = {
      cryxtalix_password = {
        neededForUsers = true;
      };
    };
  };
}