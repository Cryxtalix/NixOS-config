{ config, pkgs, pkgs_unstable, ... }:

{
  programs.neovim = {
    enable = true;
    package = pkgs_unstable.neovim-unwrapped;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    plugins = with pkgs_unstable.vimPlugins; [
      {
        # Theme
        plugin = catppuccin-nvim;
        type = "lua";
        config = ''
          require("catppuccin").setup()
          vim.cmd.colorscheme "catppuccin"
        '';
      }

      {
        # File searching
        plugin = telescope-nvim;
        type = "lua";
        config = ''
          local builtin = require("telescope.builtin")
          vim.keymap.set('n', '<C-f>', builtin.find_files, {})
          vim.keymap.set('n', '<C-g>', builtin.live_grep, {})
        '';
      }

      {
        # Syntax highlighting
        plugin = nvim-treesitter.withAllGrammars;
        type = "lua";
        config = ''
          require('nvim-treesitter.configs').setup({
            highlight = { enable = true },
            indent = { enable = true },
          })
        '';
      }

      {
        # File tree
        plugin = neo-tree-nvim;
        type = "lua";
        config = ''
          vim.keymap.set('n', '<C-t>', ':Neotree filesystem reveal left<CR>', {})
          require('neo-tree').setup {
            filesystem = {
              filtered_items = {
                visible = true,
                show_hidden_count = true,
                hide_dotfiles = false,
                hide_gitignored = false,
                hide_by_name = {
                  ".DS_Store",
                  "thumbs.db",
                },
                never_show = {
                  ".git"
                },
              },
            }
          }
        '';
      }

      # Dependencies
      plenary-nvim
      nvim-web-devicons
      nui-nvim
    ];

    extraLuaConfig = ''
      vim.g.mapleader = " "
    '';

    extraPackages = with pkgs; [
      ripgrep # Requirement for telescope
    ];
  };
}