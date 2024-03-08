{ config, lib, pkgs, user, user_profile, ... }:

{
  options.custom = {
    sops-nix.enable = lib.mkEnableOption "Enables Sops-Nix";
  };

  config = lib.mkIf config.custom.sops-nix.enable {
    sops = {
      age.keyFile = "${user.homeDir}/.config/sops/age/keys.txt";
      defaultSopsFile = ../user/${user_profile}/secrets.yaml;
      defaultSopsFormat = "yaml";
    };
  };
}