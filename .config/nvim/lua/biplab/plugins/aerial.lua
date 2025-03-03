return {
  'stevearc/aerial.nvim',
  opts = {},
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },

  config = function()
    require('aerial').setup {
      layout = {
        default_direction = 'left',
      },
    }
    vim.keymap.set('n', '<leader>a', '<cmd>AerialToggle<CR>')
  end,
}
