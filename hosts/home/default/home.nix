{ config, lib, pkgs, pkgs_unstable, username, is_nixos, configDir, ... }:

  let
    pkgs_general = with pkgs; [
      arduino
      chromium
      ddrescue
      discord
      distrobox
      element-desktop
      ffmpeg
      firefox
      pkgs_unstable.foliate
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
      p7zip
      podman
      python3
      qbittorrent-qt5
      qemu
      realvnc-vnc-viewer
      telegram-desktop
      unrar
      virt-manager
      vlc
      vscode
      wineWowPackages.stable
      winetricks
      xivlauncher
    ];

    pkgs_nixos = with pkgs; [
      virtualbox
    ];

    pkgs_not_nixos = with pkgs; [
      openssl
      sops
      wget
    ];
  in

{
  imports = [
    ../../../packages
  ];

  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true; # Do not change
  targets.genericLinux.enable = if is_nixos then false else true;

  home = {
    username = username;
    homeDirectory = "/home/${username}";
    stateVersion = "23.11"; # Do not change

    packages = if is_nixos then (
      lib.mkMerge [pkgs_general pkgs_nixos]
    ) else (
      lib.mkMerge [pkgs_general pkgs_not_nixos]
    );

    file = {
      # dotfiles
    };

    sessionVariables = {
      # EDITOR = "emacs";
    };
  };
}
