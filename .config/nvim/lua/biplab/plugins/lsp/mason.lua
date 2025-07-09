return {
  'mason-org/mason.nvim',
  dependencies = {
    'mason-org/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    'neovim/nvim-lspconfig',
  },
  config = function()
    local mason = require 'mason'
    local mason_lspconfig = require 'mason-lspconfig'
    local mason_tool_installer = require 'mason-tool-installer'

    mason.setup {
      ui = {
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗',
        },
      },
    }

    mason_lspconfig.setup {
      ensure_installed = {
        'lua_ls',
        'clangd',
        'gopls',
        'yamlls',
        'kotlin_lsp',
      },
    }

    mason_tool_installer.setup {
      ensure_installed = {
        'stylua',
        'prettier',
        'gofumpt',
        'goimports-reviser',
        'golines',
        'ktlint',
      },
    }
  end,
}
