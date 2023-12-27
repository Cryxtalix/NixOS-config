# My NixOS Configuration
Uses home-manager and flakes.

## To update system packages:
$ `sudo nixos-rebuild switch --flake .`

## To update home packages
$ `home-manager switch --flake .`

## To update flake
$ `nix flake update`

## To start development environment
$ `nix-dev <choice_of_language>`