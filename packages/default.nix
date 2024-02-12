{ config, pkgs, ... }:

{
  imports = [
    ./bash.nix
    ./git.nix
  ];
}