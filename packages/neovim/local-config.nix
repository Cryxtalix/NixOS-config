/* 
Install neovim and configuration in ./nvim folder. Contents of the 
folder will be recursively copied to the ~/.config/nvim.
*/

{ pkgs, pkgs_unstable, ... }:

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