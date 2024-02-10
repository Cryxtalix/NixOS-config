{ config, pkgs, ... }:

{
  imports = [
    ./firewall
    ./networking
    ./sound
  ];
}