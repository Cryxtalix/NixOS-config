{ config, lib, pkgs, ... }:

{
  networking.firewall = {
    enable = true;
    
    allowedTCPPorts = [];
    allowedTCPPortRanges = [
      { from = 1714; to = 1764; }
    ];

    allowedUDPPorts = [];
    allowedUDPPortRanges = [
      { from = 1714; to = 1764; }
    ];
  };
}