{ config, lib, pkgs, user, user_profile, ... }:

{
  sops = {
    age.keyFile = "${user.homeDir}/.config/sops/age/keys.txt";
    defaultSopsFile = ../user/${user_profile}/secrets.yaml;
    defaultSopsFormat = "yaml";
  };
}