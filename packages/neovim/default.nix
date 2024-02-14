{ config, pkgs, pkgs_unstable, ... }:

{
  programs.neovim = {
    enable = true;
    package = pkgs_unstable.neovim-unwrapped;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  home.file = {
    "./.config/nvim/" = {
      source = ./nvim;
      recursive = true;
    };
  };
}