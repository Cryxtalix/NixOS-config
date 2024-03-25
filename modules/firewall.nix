{ config, lib, pkgs, ... }:
with lib;
{
  options.modules = {
    firewall = {
      enable = mkOption {
        type = types.bool;
        default = true;
      };
    };
  };

  config = mkIf config.modules.firewall.enable {
    networking.firewall.enable = true;
  };
}