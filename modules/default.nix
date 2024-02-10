{ config, pkgs, ... }:

{
  imports = [
    ./networking
    ./nix-specific
    ./sound
    ./system
  ];
}