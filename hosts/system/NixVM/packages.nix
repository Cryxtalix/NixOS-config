{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    git
    home-manager
    sops
    tailscale
    wget
  ];

  services = {
    switcherooControl.enable = true;
    spice-webdavd.enable = true;
    spice-vdagentd.enable = true;
    printing.enable = false;
    xserver = {
      enable = true;
      # Keyboard
      layout = "us";
      xkbVariant = "";
      # Mouse and touchpad
      # Let DE auto configure
      /* libinput = {
        enable = true;
        touchpad.tapping = true;
      }; */

      excludePackages = [ pkgs.xterm ];
    };
  };

  virtualisation.podman = {
  	enable = true;
  	enableNvidia = true;
  };
}