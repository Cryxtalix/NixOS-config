{ config, pkgs, timezone, locale, ... }:

{
  time.timeZone = timezone;

  i18n.defaultLocale = locale;

  i18n.extraLocaleSettings = {
    LC_ADDRESS = locale;
    LC_IDENTIFICATION = locale;
    LC_MEASUREMENT = locale;
    LC_MONETARY = locale;
    LC_NAME = locale;
    LC_NUMERIC = locale;
    LC_PAPER = locale;
    LC_TELEPHONE = locale;
    LC_TIME = locale;
  };

  services = {
    printing.enable = false;
    xserver = {
      enable = true; # Enable the X11 windowing system.
      layout = "us"; # Keyboard
      xkbVariant = "";
      # Enable touchpad support (enabled default in most desktopManager).
      #libinput.enable = true;

      excludePackages = [ pkgs.xterm ];
    };
  };
}