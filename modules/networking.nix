{ config, lib, pkgs, hostname, ... }:

{
  options.custom = {
    use_networkmanager = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  config = {
    sops.secrets."wireless.env" = { };

    networking = lib.mkMerge [
      {
        hostName = hostname;
        enableIPv6 = true;
      }

      (lib.mkIf (config.custom.use_networkmanager) {
        networkmanager.enable = true;
      })

      (lib.mkIf (!config.custom.use_networkmanager) {
        wireless = {
          enable = true;
          interfaces = [ "wlan0" ];
          scanOnLowSignal = true;
          environmentFile = config.sops.secrets."wireless.env".path;
          networks = {
            "@home_ssid@" = {
              psk = "@home_psk@";
              priority = 10;
            };
            "@hotspot_ssid@" = {
              psk = "@hotspot_psk@";
              priority = 0;
            };
          };
        };
      })
    ];
  };
}