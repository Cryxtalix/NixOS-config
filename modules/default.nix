{ config, pkgs, ... }:

{
  imports = [
    ./firewall
    ./networking
    ./nix_specific
    ./sound
    ./system
  ];
}