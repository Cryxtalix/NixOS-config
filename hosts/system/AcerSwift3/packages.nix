{ pkgs, config, ... }:

{
  nixpkgs.config = {
    allowUnfree = true;
    cudaSupport = true;
  };

  environment.systemPackages = with pkgs; [
    docker
    git
    gnupg
    home-manager
    linux-manual
    man-pages
    man-pages-posix
    nvidia-docker
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
    #waydroid.enable = true;
    docker = {
      enableNvidia = true;
      extraOptions = "--add-runtime nvidia=/run/current-system/sw/bin/nvidia-container-runtime";
    };
  };
  hardware.nvidia-container-toolkit.enable = true;
  # Manpages
  documentation = {
    enable = true;
    dev.enable = true;
    man.enable = true;
  };
}