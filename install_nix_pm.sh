#! /bin/bash
# ONLY FOR FIRST TIME INSTALLING NIX PACKAGE MANAGER!
# Installs Nix package manager and home-manager
# Installs minimal home-manager config  q

if [[ $EUID -ne 0 ]]; then
    echo "This script requires sudo privileges. Please run with sudo."
    exit 1
fi

sudo -u $(logname) sh <(curl -L https://nixos.org/nix/install) --no-daemon &&
sudo -u $(logname) . ~/.nix-profile/etc/profile.d/nix.sh &&
sudo -u $(logname) nix-channel --add https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz home-manager &&
sudo -u $(logname) nix-channel --update &&
sudo -u $(logname) nix-shell '<home-manager>' -A install &&
sudo mkdir ~/.config/nix &&
sudo chown $(whoami) ~/.config/nix &&
sudo -u $(logname) echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf &&
sudo -u $(logname) home-manager switch -b backup --flake ~/NixOS-config/#minimal