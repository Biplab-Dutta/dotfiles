return {
  'nvim-treesitter/nvim-treesitter',
  event = { 'BufReadPre', 'BufNewFile' },
  build = ':TSUpdate',
  dependencies = {
    'windwp/nvim-ts-autotag',
    'hiphish/rainbow-delimiters.nvim',
  },
  config = function()
    local treesitter = require 'nvim-treesitter.configs'

    treesitter.setup {
      highlight = {
        enable = true,
        use_languagetree = true,
      },
      indent = { enable = true },
      autotag = { enable = true },
      ensure_installed = {
        'json',
        -- 'javascript',
        -- 'typescript',
        -- 'tsx',
        'yaml',
        -- 'html',
        -- 'css',
        -- 'markdown',
        -- 'markdown_inline',
        'bash',
        'lua',
        'vim',
        'dockerfile',
        'gitignore',
        -- 'vimdoc',
        'go',
        'c',
        'cpp',
        'dart',
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<C-space>',
          node_incremental = '<C-space>',
          scope_incremental = false,
          node_decremental = '<bs>',
        },
      },
    }
  end,
}
