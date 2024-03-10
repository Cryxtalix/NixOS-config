{
  imports = [
    ./hardware-configuration.nix
    ./packages.nix
    ../../../modules
  ];

  modules = {
    de.gnome = true;
    firewall.enable = true;
    sound.enable = true;
  };

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";
  boot.loader.grub.useOSProber = true;
}
