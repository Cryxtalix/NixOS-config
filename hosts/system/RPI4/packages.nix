{ config, pkgs, lib, ... }:

{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    git
    home-manager
    sops
    wget
  ];

  services = {
    openssh.enable = true;
  };
}
