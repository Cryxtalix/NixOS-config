{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    git
    git-crypt
    home-manager
    openssl
    sops
    wget
  ];

  # Program enable
  services = {
    #openssh.enable = true;
    switcherooControl.enable = true;
    spice-webdavd.enable = true;
    spice-vdagentd.enable = true;
  };
  virtualisation.podman = {
  	enable = true;
  	enableNvidia = true;
  };
}