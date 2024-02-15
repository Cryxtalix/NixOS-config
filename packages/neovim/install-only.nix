/* 
Install neovim, but without configuration.
*/

{ config, pkgs, pkgs_unstable, ... }:

{
  programs.neovim = {
    enable = true;
    package = pkgs_unstable.neovim-unwrapped;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };
}