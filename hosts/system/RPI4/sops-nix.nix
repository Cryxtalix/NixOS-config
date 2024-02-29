{ config, ... }:

{
  sops = {
    age.keyFile = "/home/rpi4/.config/sops/age/keys.txt";
    defaultSopsFile = ../../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
  };
}