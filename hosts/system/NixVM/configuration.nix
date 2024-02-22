{ config, lib, pkgs, timezone, locale, username, hostname, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../../modules

    # Select DE
    ../../../modules/DE/gnome.nix
  ];

  # ---------------------------BOOTLOADER START---------------------------
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";
  boot.loader.grub.useOSProber = true;
  # ---------------------------BOOTLOADER END---------------------------

  # ---------------------------PACKAGES START---------------------------
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    git
    git-crypt
    home-manager
    openssl
    sops
    wget
  ];

  # Program enable
  services = {
    #openssh.enable = true;
    switcherooControl.enable = true;
    spice-webdavd.enable = true;
    spice-vdagentd.enable = true;
  };
  virtualisation.podman = {
  	enable = true;
  	enableNvidia = true;
  };
  # ---------------------------PACKAGES END---------------------------

  system.stateVersion = "23.11"; # Do not change

}
