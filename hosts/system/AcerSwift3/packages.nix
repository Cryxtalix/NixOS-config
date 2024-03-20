{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    git
    gnupg
    home-manager
    sops
    switcheroo-control
    tailscale
    wget
  ];

  # Program enable
  services = {
    openssh.enable = true;
    tailscale.enable = true;
    switcherooControl.enable = true;
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
}