{ config, lib, pkgs, timezone, locale, username, hostname, ... }:

{
  imports = [
    #./hardware-configuration.nix
    ../../../modules
    
    # Select DE
    ../../../modules/DE/gnome.nix
  ];

  # ---------------------------BOOTLOADER START---------------------------
  #boot.loader.grub.enable = true;
  #boot.loader.grub.device = "/dev/vda";
  #boot.loader.grub.useOSProber = true;

  boot = {
    loader = {
      grub.enable = true;
      efiSupport = true;
      efiInstallAsRemoveable = true;
    };
    initrd.availableKernelModules = [ "ahci" "xhci_pci" "virtio_pci" "sr_mod" "virtio_blk" ];
    boot.kernelModules = [ "kvm-intel" ];
  };
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
