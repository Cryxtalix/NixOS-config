{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraLuaConfig = ''
    '';

    plugins = with pkgs.vimPlugins; [
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