{ pkgs, pkgs_unstable, user, is_nixos, ... }:

{
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    distrobox
    firefox
    podman
  ]
  ++
  (if is_nixos then with pkgs; [
    # Only when NixOS
  ]
  else with pkgs; [
    # Only when not NixOS
    sops
    wget
  ]);
}