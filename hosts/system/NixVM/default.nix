{
  imports = [
    ./hardware-configuration.nix
    ./packages.nix
    ../../../modules

    # Select DE
    ../../../modules/DE/gnome.nix
  ];

  custom = {
    firewall.enable = true;
    git-daemon.enable = false;
    use_networkmanager = true;
    nix-ld.enable = true;
    nvidia_gpu.enable = false;
    sops-nix.enable = true;
    sound.enable = true;
  };

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";
  boot.loader.grub.useOSProber = true;

  system.stateVersion = "23.11"; # Do not change
}
