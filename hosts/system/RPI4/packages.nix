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
    openssh.enable = true;
    tailscale.enable = true;
  };
}
