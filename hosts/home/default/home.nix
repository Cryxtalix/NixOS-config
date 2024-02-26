{ pkgs, pkgs_unstable, username, is_nixos, ... }:

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
      p7zip
      podman
      python3
      qbittorrent-qt5
      qemu
      realvnc-vnc-viewer
      telegram-desktop
      trayscale
      unrar
      virt-manager
      vlc
      vscode
      wineWowPackages.stable
      winetricks
      xivlauncher
    ] 
    ++ 
    (if is_nixos then with pkgs; [
      # Only when NixOS
      virtualbox
    ]
    else with pkgs; [
      # Only when not NixOS
      git-crypt
      openssl
      sops
      wget
    ]);

    file = {
      # dotfiles
    };

    sessionVariables = {
      EDITOR = "neovim";
    };
  };
}
