{ config, lib, pkgs, hostname, ... }:
with lib;
{
  options.modules = {
    wifi = {
      enable = mkEnableOption "Enables wifi connectivity";
      networkmanager = mkEnableOption "Uses network manager";
    };
  };

  config = mkIf config.modules.wifi.enable {
    sops.secrets."wireless.env" = { };
    systemd.services.NetworkManager-ensure-profiles.after = [ "NetworkManager.service" ]; # Temp workaround

    networking = mkMerge [
      {
        hostName = hostname;
        enableIPv6 = true;
      }

      (mkIf (config.modules.wifi.networkmanager) {
        networkmanager.enable = true;
      })

      (mkIf (!config.modules.wifi.networkmanager) {
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