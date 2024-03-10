{ config, lib, pkgs, user, user_profile, ... }:

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

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ 
        "nix-command"
        "flakes"
      ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    package = pkgs.nixFlakes;
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

  sops = {
    age.keyFile = "${user.homeDir}/.config/sops/age/keys.txt";
    defaultSopsFile = ../user/${user_profile}/secrets.yaml;
    defaultSopsFormat = "yaml";
  };

  system.stateVersion = "23.11"; # Do not change
}