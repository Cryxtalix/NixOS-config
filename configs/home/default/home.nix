{ config, pkgs, unstable, username, is_nixos, configDir, ... }:

  let
    sops = {
      age.keyFile = "/home/" + username + "/.config/sops/age/keys.txt";
      defaultSopsFile = ../../../secrets/secrets.yaml;
      defaultSopsFormat = "yaml";
    };
  in

{
  # SOPS
  systemd.user.services.mbsync.Unit.After = [ "sops-nix.service" ];

  nixpkgs.config.allowUnfree = true;
  home.username = username;
  home.homeDirectory = "/home/" + username;
  home.stateVersion = "23.11"; # Do not change
  programs.home-manager.enable = true; # Do not change
  targets.genericLinux.enable = if is_nixos then false else true;

  sops.secrets.example_key = { };

  # Programs added here are managed by home-manager
  imports = [
    ../../user/shell/sh.nix
    ../../user/editor/neovim.nix
    ../../user/apps/git.nix
  ];

  # Installed packages
  home.packages = with pkgs; [
    arduino
    chromium
    ddrescue
    discord
    distrobox
    element-desktop
    ffmpeg
    firefox
    unstable.foliate
    gittyup
    gnome.gnome-boxes
    gnome.gnome-tweaks
    gnome-extension-manager
    gnomeExtensions.alphabetical-app-grid
    gnomeExtensions.blur-my-shell
    gnomeExtensions.caffeine
    gnomeExtensions.gsconnect # Check https://userbase.kde.org/KDEConnect#Troubleshooting
    htop
    libreoffice
    libvirt
    lutris
    marker
    neofetch
    nerdfonts
    nurl
    openssl
    p7zip
    podman
    python3
    qbittorrent-qt5
    qemu
    realvnc-vnc-viewer
    switcheroo-control
    telegram-desktop
    unrar
    virtualboxExtpack
    virtualboxWithExtpack
    virt-manager
    vlc
    vscode
    wget
    wineWowPackages.stable
    winetricks
    xivlauncher
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/cryxtalix/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };
}
