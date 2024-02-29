{ config, ... }:

{
  sops = {
    age.keyFile = "/home/rpi4/.config/sops/age/keys.txt";
    defaultSopsFile = ../../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
      
    secrets = {
      "home_wifi/ssid".owner = config.users.users.rpi4.name;
      "home_wifi/password".owner = config.users.users.rpi4.name;
    };
  };
}