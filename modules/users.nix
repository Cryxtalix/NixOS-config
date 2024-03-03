{ config, lib, pkgs, ... }:

{
  users = {
    mutableUsers = false;
    extraGroups = {
      vboxusers.members = [ "user-with-access-to-virtualbox" ];
    };

    users = {
      cryxtalix = {
        description = "Main user";
        isNormalUser = true;
        hashedPasswordFile = config.sops.secrets.cryxtalix_password.path;
        extraGroups = [
          "networkmanager"
          "wheel"
          "podman"
          "vboxusers"
        ];
      };
    };
  };

  sops.secrets.cryxtalix_password.neededForUsers = true;
}