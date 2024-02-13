{ config, pkgs, pkgs_unstable, ... }:

{
  programs.neovim = {
    enable = true;
    package = pkgs_unstable.neovim-unwrapped;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraLuaConfig = ''
    '';

    plugins = with pkgs_unstable.vimPlugins; [
      nvchad
      nvchad-ui

      /* {
        plugin = something;
        type = "lua";
        config = "";
      } */

    ];
  };
}