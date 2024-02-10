{ config, pkgs, hostname, ... }:

{
  networking = {
    hostName = hostname;
    networkmanager.enable = true;
    enableIPv6 = true;
    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    # Configure network proxy if necessary
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    firewall = {
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
  };
}