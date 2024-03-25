{ config, lib, pkgs, ... }:
with lib;
{
  options.modules = {
    firewall = {
      enable = mkEnableOption "Enables firewall";
    };
  };

  config = mkIf config.modules.firewall.enable {
    networking.firewall.enable = true;
  };
}