{ config, lib, pkgs, ... }:

{
  users.users = {
    cryxtalix = {
      description = "Main user";
      isNormalUser = true;
      hashedPassword = "$y$j9T$V5J0P4h1B8F6zp6YqCdp2/$.Y4pdvAaubE6aB4tramHLnd1qmhwTlE9BdjqNRJhbzD";
      extraGroups = [
        "networkmanager"
        "wheel"
        "podman"
        "vboxusers"
        "dialout"
      ];
    };
  };
}