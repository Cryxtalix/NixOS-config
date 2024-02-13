{ config, pkgs, ... }:

{
  imports = [
    ./bash.nix
    ./git.nix
    ./neovim.nix
    ./nix-direnv.nix
  ];
}