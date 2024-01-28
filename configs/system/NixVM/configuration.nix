{ config, lib, pkgs, timezone, locale, username, hostname, ... }:

{
  # ---------------------------SYSTEM SETTINGS START---------------------------
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    package = pkgs.nixFlakes;
  };

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";
  boot.loader.grub.useOSProber = true;

  boot.initrd.luks.devices."luks-2b8b3184-6e61-4b2b-9d0d-4f2bf7478d06".device = "/dev/disk/by-uuid/2b8b3184-6e61-4b2b-9d0d-4f2bf7478d06";
  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  boot.loader.grub.enableCryptodisk=true;

  boot.initrd.luks.devices."luks-7b694112-f069-47c3-8b0c-b411ba4f533d".keyFile = "/crypto_keyfile.bin";
  boot.initrd.luks.devices."luks-2b8b3184-6e61-4b2b-9d0d-4f2bf7478d06".keyFile = "/crypto_keyfile.bin";

  networking.hostName = hostname; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = timezone;

  # Select internationalisation properties.
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
  
  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;
  # ---------------------------SYSTEM SETTINGS END---------------------------

  # ---------------------------ADD USERS START---------------------------
  # Don't forget to set a password with ‘passwd’.
  users.users.cryxtalix = {
    isNormalUser = true;
    description = username;
    extraGroups = [ "networkmanager" "wheel" ];
  };
  # ---------------------------ADD USERS END---------------------------

  # ---------------------------DISPLAY OPTIONS START---------------------------
  services.xserver = {
    # Enable the X11 windowing system.
    enable = true;

    # Enable the GNOME Desktop Environment.
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;

    # Configure keymap in X11
    layout = "us";
    xkbVariant = "";
  };
  # ---------------------------DISPLAY OPTIONS END---------------------------

  # ---------------------------SOUND OPTIONS START---------------------------
  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };
  # ---------------------------SOUND OPTIONS END---------------------------

  # ---------------------------MISC OPTIONS START---------------------------
  # Enable CUPS to print documents.
  services.printing.enable = false;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
  # ---------------------------MISC OPTIONS END---------------------------

  # ---------------------------PACKAGES START---------------------------
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    home-manager
    spice
    spice-gtk
    switcheroo-control
  ];

  # Program enable
  services = {
    switcherooControl.enable = true;
    spice-webdavd.enable = true;
    spice-vdagentd.enable = true;
  };

  # Remove unwanted packages
  services.xserver.excludePackages = [ pkgs.xterm ];
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
  ];
  # ---------------------------PACKAGES END---------------------------

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
