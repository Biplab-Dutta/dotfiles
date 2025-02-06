return {
  'nvim-flutter/flutter-tools.nvim',
  lazy = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'stevearc/dressing.nvim',
  },
  config = function()
    require('flutter-tools').setup {
      decorations = {
        statusline = {
          app_version = true,
          device = true,
          project_config = false,
        },
      },
      widget_guides = {
        enabled = true,
      },
    }

    -- Explicitly load the Telescope extension for Flutter
    require('telescope').load_extension 'flutter'

    -- Set up the keymap after loading the extension
    vim.keymap.set('n', '<leader>r', '<cmd>Telescope flutter commands<CR>', { desc = 'Open Flutter commands' })
  end,
}
