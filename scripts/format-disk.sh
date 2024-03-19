#!/usr/bin/env bash

sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko ~/NixOS-config/hosts/system/AcerSwift3/luks-btrfs.nix
