{
  imports = [
    ./hardware-configuration.nix
    ./packages.nix
    ../../../modules
  ];

  modules = {
    de.gnome = true;
    firewall = {
      enable = true;
      gsconnect_ports = true;
    };
    wifi = {
      enable = true;
      networkmanager = true;
    };
    nvidia_gpu.enable = true;
    sound.enable = true;
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices."luks-9afc09d7-6a1a-45df-9caf-036b6503ab56".device = "/dev/disk/by-uuid/9afc09d7-6a1a-45df-9caf-036b6503ab56";
}
