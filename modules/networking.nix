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
        networkmanager = {
          enable = true;
          ensureProfiles = {
            environmentFiles = [
              config.sops.secrets."wireless.env".path
            ];
            profiles = {
              "@hotspot_ssid@" = {
                connection = {
                  id = "@hotspot_ssid@";
                  uuid = "30c305a4-0568-4e0a-8aa3-f1d604791270";
                  type = "wifi";
                  interface-name = "wlp0s20f3";
                };
                wifi = {
                  mode = "infrastructure";
                  ssid = "@hotspot_ssid@";
                };
                wifi-security = {
                  auth-alg = "open";
                  key-mgmt = "wpa-psk";
                  psk = "@hotspot_psk@";
                };
                ipv4 = {
                  method = "auto";
                };
                ipv6 = {
                  addr-gen-mode = "default";
                  method = "auto";
                };
                proxy = {
                };
              };

              "@home_ssid@" = {
                connection = {
                  id = "@home_ssid@";
                  uuid = "2474ab5c-facd-40a6-bbcb-78a86b6ca4a2";
                  type = "wifi";
                  interface-name = "wlp0s20f3";
                };
                wifi = {
                  mode = "infrastructure";
                  ssid = "@home_ssid@";
                };
                wifi-security = {
                  auth-alg = "open";
                  key-mgmt = "wpa-psk";
                  psk = "@home_psk@";
                };
                ipv4 = {
                  method = "auto";
                };
                ipv6 = {
                  addr-gen-mode = "default";
                  method = "auto";
                };
                proxy = {
                };
              };
            };
          };
        };
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