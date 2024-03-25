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
    virtualbox.enable = true;
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices."luks-538e3ad8-51fc-4329-9046-dff1044d0429".device = "/dev/disk/by-uuid/538e3ad8-51fc-4329-9046-dff1044d0429";
}
