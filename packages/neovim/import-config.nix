/* 
Install neovim and import configuration from github repo 
*/

{ pkgs, ... }:
  let
    neovim = pkgs.fetchFromGitHub{
      owner = "Cryxtalix";
      repo = "nvim";
      rev = "";
      sha256 = "";
    };
  in
{
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  home.file = {
    ".config/nvim/" = {
      source = "${neovim}";
      recursive = true;
    };
  };
}