{ hostname, config, ... }:
let
  SSID = config.sops.secrets."home_wifi/ssid".path;
  SSIDpassword = config.sops.secrets."home_wifi/password".path;
in
{
  networking = {
    hostName = hostname;
    wireless = {
      enable = true;
      networks."${SSID}".psk = SSIDpassword;
      interfaces = [ "wlan0" ];
    };
  };
}