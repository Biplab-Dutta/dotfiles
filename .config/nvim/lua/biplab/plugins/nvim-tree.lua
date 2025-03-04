return {
  'nvim-tree/nvim-tree.lua',
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    local nvimtree = require 'nvim-tree'

    -- recommended settings from nvim-tree documentation
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    nvimtree.setup {
      view = {
        width = 35,
        relativenumber = false,
        side = 'right',
      },

      renderer = {
        indent_markers = {
          enable = true,
        },
        icons = {
          glyphs = {
            folder = {
              arrow_closed = '›', -- arrow when folder is closed
              arrow_open = '⌄', -- arrow when folder is open
            },
            git = {
              staged = 'A',
              unstaged = 'M',
              unmerged = '!',
              renamed = 'R',
              untracked = 'U',
              deleted = 'D',
              ignored = '◌',
            },
          },
        },
      },
      -- on_attach = function(bufnr)
      --   local api = require 'nvim-tree.api'
      --
      --   -- Use the default mappings
      --   api.config.mappings.default_on_attach(bufnr)
      --
      --   -- Add spacebar mapping for opening files/folders
      --   vim.keymap.set('n', '<space>', api.node.open.edit, {
      --     buffer = bufnr,
      --     noremap = true,
      --     silent = true,
      --     desc = 'Open file or folder',
      --   })
      -- end,

      -- disable window_picker for
      -- explorer to work well with
      -- window splits
      actions = {
        open_file = {
          window_picker = {
            enable = false,
          },
        },
      },
      filters = {
        dotfiles = true,
        custom = { '.DS_Store' },
      },
      git = {
        ignore = false,
      },
    }

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set('n', '<leader>ee', '<cmd>NvimTreeToggle<CR>', { desc = 'Toggle file explorer' }) -- toggle file explorer
    keymap.set('n', '<leader>ef', '<cmd>NvimTreeFindFileToggle<CR>', { desc = 'Toggle file explorer on current file' }) -- toggle file explorer on current file
    keymap.set('n', '<leader>ec', '<cmd>NvimTreeCollapse<CR>', { desc = 'Collapse file explorer' }) -- collapse file explorer
    keymap.set('n', '<leader>er', '<cmd>NvimTreeRefresh<CR>', { desc = 'Refresh file explorer' }) -- refresh file explorer
  end,
}
