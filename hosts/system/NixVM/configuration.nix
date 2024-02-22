{ config, lib, pkgs, timezone, locale, username, hostname, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../../modules
    ../../../modules/sops-nix.nix

    # Select DE
    ../../../modules/DE/gnome.nix
  ];

  # ---------------------------BOOTLOADER START---------------------------
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";
  boot.loader.grub.useOSProber = true;
  # ---------------------------BOOTLOADER END---------------------------

  # ---------------------------USERS START---------------------------
  users.mutableUsers = false;
  
  users.users."${username}" = {
    description = "Main user";
    isNormalUser = true;
    hashedPasswordFile = config.sops.secrets.cryxtalix_password.path;
    extraGroups = [
      "networkmanager"
      "wheel"
      "podman"
    ];
  };
  # ---------------------------USERS END---------------------------

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
