{ pkgs, user, is_nixos, ... }:

{
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    arduino
    chromium
    distrobox
    element-desktop
    ffmpeg
    firefox
    foliate
    gittyup
    gnome.gnome-boxes
    gnome.gnome-tweaks
    htop
    impression
    libreoffice
    libvirt
    lutris
    marker
    neofetch
    p7zip
    podman
    python3
    qbittorrent-qt5
    qemu
    scrcpy
    stellarium
    telegram-desktop
    trayscale
    unrar
    virt-manager
    vlc
    vscode-fhs
    webcord
    wineWowPackages.stable
    winetricks
    xivlauncher
  ] 
  ++ 
  (if is_nixos then with pkgs; [
    # Only when NixOS
  ]
  else with pkgs; [
    # Only when not NixOS
    gnomeExtensions.gsconnect
    sops
    wget
  ]);
}