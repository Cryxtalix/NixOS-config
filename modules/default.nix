{ config, pkgs, ... }:

{
  imports = [
    ./networking
    ./nix_specific
    ./sound
    ./system
  ];
}