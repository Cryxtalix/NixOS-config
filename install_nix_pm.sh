#! /bin/bash
# ONLY FOR FIRST TIME INSTALLING NIX PACKAGE MANAGER!
# Installs Nix package manager and home-manager
# Installs minimal home-manager config

if [[ $EUID -ne 0 ]]; then
    echo "This script requires sudo privileges. Please run with sudo."
    exit 1
fi

sh <(curl -L https://nixos.org/nix/install) --no-daemon &&
. ~/.nix-profile/etc/profile.d/nix.sh &&
nix-channel --add https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz home-manager &&
nix-channel --update &&
nix-shell '<home-manager>' -A install &&
sudo mkdir ~/.config/nix &&
sudo chown $(whoami) ~/.config/nix &&
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf &&
home-manager switch -b backup --flake ~/NixOS-config/#minimal