{ config, pkgs, pkgs_unstable, username, is_nixos, configDir, ... }:

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

    packages = with pkgs; [
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
      openssl
      p7zip
      podman
      python3
      qbittorrent-qt5
      qemu
      realvnc-vnc-viewer
      sops
      switcheroo-control
      telegram-desktop
      unrar
      #virtualbox
      virt-manager
      vlc
      vscode
      wget
      wineWowPackages.stable
      winetricks
      xivlauncher
    ];

    file = {
      # dotfiles
    };

    sessionVariables = {
      # EDITOR = "emacs";
    };
  };
}
