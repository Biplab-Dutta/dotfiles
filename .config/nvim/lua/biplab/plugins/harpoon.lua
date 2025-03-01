return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },

  config = function()
    local harpoon = require 'harpoon'
    local extensions = require 'harpoon.extensions'
    harpoon.setup {}

    harpoon:extend(extensions.builtins.navigate_with_number())
    harpoon:extend(extensions.builtins.highlight_current_file())

    vim.keymap.set('n', '<leader>ha', function()
      harpoon:list():add()
    end)

    vim.keymap.set('n', '<leader>hw', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end)

    vim.keymap.set('n', '<leader>hu', function()
      harpoon:list():prev()
    end)

    vim.keymap.set('n', '<leader>hd', function()
      harpoon:list():next()
    end)
  end,
}
