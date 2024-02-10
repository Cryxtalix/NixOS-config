{ config, lib, pkgs, timezone, locale, username, hostname, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../../modules
    ../../../modules/nvidia_drivers

    # Select DE
    ../../../modules/DE/gnome
  ];

  # ---------------------------BOOTLOADER START---------------------------
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices."luks-9afc09d7-6a1a-45df-9caf-036b6503ab56".device = "/dev/disk/by-uuid/9afc09d7-6a1a-45df-9caf-036b6503ab56";
  # ---------------------------BOOTLOADER END---------------------------

  # ---------------------------SECRETS START---------------------------
  sops = {
    age.keyFile = "/home/${username}/.config/sops/age/keys.txt";
    defaultSopsFile = ../../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
      
    secrets = {
      cryxtalix_password = {
        neededForUsers = true;
      };
    };
  };
  # ---------------------------SECRETS END---------------------------

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
      "vboxusers"
    ];
  };
  # ---------------------------USERS END---------------------------

  # ---------------------------PACKAGES START---------------------------
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
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

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
