{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    git
    git-crypt
    home-manager
    sops
    switcheroo-control
    wget
  ];

  # Program enable
  services = {
    switcherooControl.enable = true;
    openssh.enable = true;
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