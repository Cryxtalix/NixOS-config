{ config, lib, pkgs, user, ... }:

{
  time.timeZone = user.timezone;

  i18n.defaultLocale = user.locale;

  i18n.extraLocaleSettings = {
    LC_ADDRESS = user.locale;
    LC_IDENTIFICATION = user.locale;
    LC_MEASUREMENT = user.locale;
    LC_MONETARY = user.locale;
    LC_NAME = user.locale;
    LC_NUMERIC = user.locale;
    LC_PAPER = user.locale;
    LC_TELEPHONE = user.locale;
    LC_TIME = user.locale;
  };

  services = {
    printing.enable = false;
    xserver = {
      enable = true;
      # Keyboard
      layout = "us";
      xkbVariant = "";
      # Mouse and touchpad
      # Let DE auto configure
      /* libinput = {
        enable = true;
        touchpad.tapping = true;
      }; */

      excludePackages = [ pkgs.xterm ];
    };
  };

  users = {
    mutableUsers = false;
    extraGroups = {
      vboxusers.members = [ "user-with-access-to-virtualbox" ];
    };
  };

  system.stateVersion = "23.11"; # Do not change
}