{ config, lib, pkgs, timezone, locale, username, hostname, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../../modules
    ../../../modules/nvidia-drivers.nix

    # Select DE
    ../../../modules/DE/gnome.nix
  ];

  # ---------------------------BOOTLOADER START---------------------------
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices."luks-9afc09d7-6a1a-45df-9caf-036b6503ab56".device = "/dev/disk/by-uuid/9afc09d7-6a1a-45df-9caf-036b6503ab56";
  # ---------------------------BOOTLOADER END---------------------------

  # ---------------------------PACKAGES START---------------------------
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    git
    git-crypt
    home-manager
    openssl
    sops
    switcheroo-control
    wget
  ];

  # Program enable
  services = {
    switcherooControl.enable = true;
    openssh.enable = true;
  };
  virtualisation = {
    virtualbox = {
      host.enable = true;
      guest.enable = true;
      guest.x11 = true;
    };
    podman = {
  	  enable = true;
  	  enableNvidia = true;
    };
  };
  users.extraGroups.vboxusers.members = [ "user-with-access-to-virtualbox" ];
  # ---------------------------PACKAGES END---------------------------

  system.stateVersion = "23.11"; # Do not change

}
