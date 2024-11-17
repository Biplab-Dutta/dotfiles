return {
  'catppuccin/nvim',
  name = 'catppuccin',
  lazy = false,
  priority = 1000,
  config = function()
    require('catppuccin').setup {
      flavour = 'mocha',
      transparent_background = true,
    }

    vim.cmd [[colorscheme catppuccin]]

    local bg_transparent = true

    local toggle_transparency = function()
      bg_transparent = not bg_transparent
      require('catppuccin').setup {
        transparent_background = bg_transparent,
      }
      vim.cmd [[colorscheme catppuccin]]
    end

    vim.keymap.set('n', '<leader>bg', toggle_transparency, { noremap = true, silent = true })
  end,
}
