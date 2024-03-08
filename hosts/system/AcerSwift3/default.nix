{
  imports = [
    ./hardware-configuration.nix
    ./packages.nix
    ../../../modules

    # Select DE
    ../../../modules/DE/gnome.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices."luks-9afc09d7-6a1a-45df-9caf-036b6503ab56".device = "/dev/disk/by-uuid/9afc09d7-6a1a-45df-9caf-036b6503ab56";

  custom = {
    firewall.enable = true;
    git-daemon.enable = false;
    use_networkmanager = true;
    nix-ld.enable = true;
    nvidia_gpu.enable = true;
    sops-nix.enable = true;
    sound.enable = true;
  };

  system.stateVersion = "23.11"; # Do not change
}
