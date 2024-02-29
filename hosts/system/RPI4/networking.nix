{ hostname, config, ... }:

{
  sops.secrets."wireless.env" = { };

  networking = {
    hostName = hostname;
    enableIPv6 = true;
    wireless = {
      enable = true;
      interfaces = [ "wlan0" ];
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
  };
}