{
  imports = [
    ./hardware-configuration.nix
    ./packages.nix
    ../../../modules
    ../../../modules/nvidia-drivers.nix

    # Select DE
    ../../../modules/DE/gnome.nix
  ];

  system.stateVersion = "23.11"; # Do not change

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices."luks-9afc09d7-6a1a-45df-9caf-036b6503ab56".device = "/dev/disk/by-uuid/9afc09d7-6a1a-45df-9caf-036b6503ab56";
}
