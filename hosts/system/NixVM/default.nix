{
  imports = [
    ./hardware-configuration.nix
    ./packages.nix
    ../../../modules

    # Select DE
    ../../../modules/DE/gnome.nix
  ];

  system.stateVersion = "23.11"; # Do not change

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";
  boot.loader.grub.useOSProber = true;
}
