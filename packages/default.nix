{ config, pkgs, ... }:

{
  imports = [
    ./bash.nix
    ./git.nix
    ./neovim/install-only.nix
    ./nix-direnv.nix
  ];
}