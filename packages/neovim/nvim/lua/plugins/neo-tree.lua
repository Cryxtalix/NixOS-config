return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
    "3rd/image.nvim",
  },
  
  config = function()
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
          }
        }
      }
    }
  end
}
