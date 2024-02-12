{ config, pkgs, ... }:

{
  imports = [
    ./networking.nix
    ./nix-settings.nix
    ./sound.nix
    ./system.nix
  ];
}