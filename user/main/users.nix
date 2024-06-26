{ config, lib, pkgs, ... }:

{
  users.users = {
    cryxtalix = {
      description = "Main user";
      isNormalUser = true;
      linger = true;
      hashedPasswordFile = config.sops.secrets.cryxtalix_password.path;
      extraGroups = [
        "networkmanager"
        "wheel"
        "podman"
        "docker"
        "vboxusers"
        "dialout"
      ];
    };
  };

  sops.secrets.cryxtalix_password.neededForUsers = true;
}