{ pkgs, user, is_nixos, ... }:

{
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    arduino
    chromium
    element-desktop
    ffmpeg
    firefox
    foliate
    gittyup
    gnome.gnome-boxes
    gnome.gnome-tweaks
    hexchat
    htop
    impression
    libreoffice
    libvirt
    lutris
    marker
    neofetch
    p7zip
    qbittorrent-qt5
    qemu
    scrcpy
    stellarium
    telegram-desktop
    trayscale
    unar
    virt-manager
    vlc
    webcord
    xivlauncher
  ] 
  ++ 
  (if is_nixos then with pkgs; [
    # Only when NixOS
    distrobox
    podman
    python3
    vscode-fhs
    winetricks
    wineWowPackages.stable
  ]
  else with pkgs; [
    # Only when not NixOS
    gnomeExtensions.gsconnect
    sops
    wget
  ]);
}
