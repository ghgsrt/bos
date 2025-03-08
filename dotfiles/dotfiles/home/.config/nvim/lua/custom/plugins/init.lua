-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
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
      vim.g.gruvbox_material_enable_italic = true
      vim.cmd.colorscheme 'gruvbox-material'
    end,
  },
  {
    'HiPhish/guile.vim',
    lazy = false,
    priority = 500,
  },
}
