# My NixOS Configuration
Uses home-manager and flakes.

## To update flake:
*Fetches latest versions of nixpkgs and dependencies*

$ `nix-flake-up`

## To upgrade system packages:
$ `nix-system-up`

## To upgrade home packages:
$ `nix-home-up`

## Or to update and upgrade entire system:
$ `nix-full-up`

## To start development environment:
*Convenient env, use dev templates for project specific envs*

$ `nix-dev <choice_of_language>`