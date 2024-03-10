{ config, lib, pkgs, ... }:
with lib;
{
  options.modules = {
    firewall = {
      enable = mkEnableOption "Enables firewall";
      gsconnect_ports = mkEnableOption "Manually opens ports used by gsconnect";
    };
  };

  config = mkIf config.modules.firewall.enable {
    networking.firewall = mkMerge [
      {
        enable = true;
      }

      (mkIf (config.modules.firewall.gsconnect_ports) {
        allowedTCPPorts = [];
        allowedTCPPortRanges = [
          { from = 1714; to = 1764; }
        ];
        allowedUDPPorts = [];
        allowedUDPPortRanges = [
          { from = 1714; to = 1764; }
        ];
      })
    ];
  };
}