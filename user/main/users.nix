{ config, lib, pkgs, ... }:

{
  users.users = {
    cryxtalix = {
      description = "Main user";
      isNormalUser = true;
      hashedPasswordFile = config.sops.secrets.cryxtalix_password.path;
      extraGroups = [
        "networkmanager"
        "wheel"
        "podman"
        "vboxusers"
        "dialout"
      ];
    };
  };

  sops.secrets.cryxtalix_password.neededForUsers = true;
}