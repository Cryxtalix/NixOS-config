{ config, lib, pkgs, user, ... }:

{
  sops = {
    age.keyFile = "${user.homeDir}/.config/sops/age/keys.txt";
    defaultSopsFile = ../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
  };
}