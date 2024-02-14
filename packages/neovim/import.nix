{ config, pkgs, pkgs_unstable, ... }:
  let
    neovim = pkgs.fetchFromGitHub{
      owner = "";
      repo = "";
      rev = "";
      sha256 = "";
    };
  in
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
      source = "${neovim}/neovim.nix";
      recursive = true;
    };
  };
}