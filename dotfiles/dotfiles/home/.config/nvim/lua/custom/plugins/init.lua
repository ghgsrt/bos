-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  'norcalli/nvim-colorizer.lua',
  'tpope/vim-surround',
  'tpope/vim-repeat',
  'tpope/vim-unimpaired',
  'tpope/vim-speeddating',
  'HiPhish/rainbow-delimiters.nvim',
  'mbbill/undotree',
  'aymericbeaumet/vim-symlink',
  'theprimeagen/harpoon',
  'tpope/vim-fugitive',
  'geogitorg/neogit',
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim', -- required
      --"sindrets/diffview.nvim",        -- optional - Diff integration

      'nvim-telescope/telescope.nvim', -- optional
    },
    config = true,
  },
  'nvim-treesitter/nvim-treesitter-context',
  {
    'sainnhe/gruvbox-material',
    lazy = false,
    priority = 1000,
    config = function()
      -- Optionally configure and load the colorscheme
      -- directly inside the plugin declaration.
      vim.g.gruvbox_material_dim_inactive_window = 1
      -- vim.g.gruvbox_material_transparent_background = 2
      -- vim.g.gruvbox_material_enable_italic = true
      vim.g.gruvbox_material_colors_override = {
        bg_statusline1 = {'None', '235'},
        bg_statusline2 = {'#3a3735', '235'},
        bg_statusline3 = {'#a89984', '239'}
      }
      vim.cmd.colorscheme 'gruvbox-material'
    end,
  },
  {
    'HiPhish/guile.vim',
    lazy = false,
    priority = 500,
  },
}
