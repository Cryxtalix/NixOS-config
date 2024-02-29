{ hostname, config, ... }:

{
  sops.secrets."wireless.env" = { };

  networking = {
    hostName = hostname;
    wireless = {
      enable = true;
      enableIPv6 = true;
      interfaces = [ "wlan0" ];
      environmentFile = config.sops.secrets."wireless.env".path;
      networks = {
        "@home_ssid@".psk = "@home_psk@";
        "@hotspot_ssid@".psk = "@hotspot_psk@";
      };
    };
  };
}