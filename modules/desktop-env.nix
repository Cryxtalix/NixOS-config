{ config, lib, pkgs, ... }:
with lib;
{
  options.modules.de = {
    gnome = mkEnableOption "Enables the GNOME desktop environment";
  };

  config = mkMerge [
    (mkIf config.modules.gnome {
      # Enable the GNOME Desktop Environment.
      services.xserver = {
        displayManager.gdm.enable = true;
        desktopManager.gnome.enable = true;
      };

      environment.gnome.excludePackages = with pkgs; [
        gnome-tour
        nixos-render-docs
        gnome.epiphany
        gnome.geary
        gnome.seahorse
        gnome.totem
        gnome.yelp
        gnome.gnome-contacts
        gnome.gnome-maps
        gnome.gnome-music
        gnome.gnome-weather
        gnome.simple-scan
        snapshot
      ];
    })
  ];
}