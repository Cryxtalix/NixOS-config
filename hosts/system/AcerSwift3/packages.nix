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
      xkb = {
        layout = "us";
        variant = "";
      };
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
    podman.enable = true;
    containers.cdi.dynamic.nvidia.enable = true;
  };
}