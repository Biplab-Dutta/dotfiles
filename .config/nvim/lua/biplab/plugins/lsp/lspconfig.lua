return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    { 'antosha417/nvim-lsp-file-operations', config = true },
    { 'folke/neodev.nvim' },
    { 'j-hui/fidget.nvim' },
    { 'robertbrunhage/dart-tools.nvim' },
  },
  config = function()
    require('fidget').setup {
      notification = {
        window = {
          winblend = 0,
        },
      },
    }
    require 'dart-tools'

    vim.diagnostic.config {
      virtual_text = true,
      virtual_lines = false,
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = ' ',
          [vim.diagnostic.severity.WARN] = ' ',
          [vim.diagnostic.severity.INFO] = ' ',
          [vim.diagnostic.severity.HINT] = '󰠠 ',
        },
      },
      underline = true,
      update_in_insert = true,
      severity_sort = true,
    }

    local lspconfig = require 'lspconfig'
    local keymap = vim.keymap

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }

        opts.desc = 'Show LSP references'
        keymap.set('n', 'gR', '<cmd>FzfLua lsp_references<CR>', opts)

        opts.desc = 'Go to declaration'
        keymap.set('n', 'gD', '<cmd>FzfLua lsp_declarations<CR>', opts)

        opts.desc = 'Show LSP definitions'
        keymap.set('n', 'gd', '<cmd>FzfLua lsp_definitions<CR>', opts)

        opts.desc = 'Show LSP implementations'
        keymap.set('n', 'gi', '<cmd>FzfLua lsp_implementations<CR>', opts)

        opts.desc = 'Show LSP type definitions'
        keymap.set('n', 'gt', '<cmd>FzfLua lsp_typedefs<CR>', opts)

        opts.desc = 'See available code actions'
        keymap.set({ 'n', 'v' }, '<leader>ca', '<cmd>FzfLua lsp_code_actions<CR>', opts)

        opts.desc = 'Smart rename'
        keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)

        opts.desc = 'Show buffer diagnostics'
        keymap.set('n', '<leader>D', '<cmd>FzfLua diagnostics_document bufnr=0<CR>', opts)

        opts.desc = 'Show line diagnostics'
        keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)

        opts.desc = 'Go to previous diagnostic'
        keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)

        opts.desc = 'Go to next diagnostic'
        keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

        opts.desc = 'Show documentation for what is under cursor'
        keymap.set('n', 'K', vim.lsp.buf.hover, opts)

        opts.desc = 'Restart LSP'
        keymap.set('n', '<leader>rs', ':LspRestart<CR>', opts)

        keymap.set('n', '<leader>tdd', function()
          vim.diagnostic.config {
            virtual_lines = not vim.diagnostic.config().virtual_lines,
            virtual_text = not vim.diagnostic.config().virtual_text,
          }
        end, { desc = 'Toggle diagnostic virtual lines and virtual text' })
      end,
    })

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp_attach_disable_ruff_hover', { clear = true }),
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client == nil then
          return
        end
        if client.name == 'ruff' then
          client.server_capabilities.hoverProvider = false
        end
      end,
      desc = 'LSP: Disable hover capability from Ruff',
    })

    local native_capabilities = vim.lsp.protocol.make_client_capabilities()
    local capabilities = require('blink.cmp').get_lsp_capabilities(native_capabilities)

    vim.lsp.config('lua_ls', {
      capabilities = capabilities,
      settings = {
        Lua = {
          diagnostics = {
            disable = { 'missing-fields' },
          },
          completion = {
            callSnippet = 'Replace',
          },
        },
      },
    })

    lspconfig.dartls.setup {
      capabilities = capabilities,
      cmd = {
        vim.fn.exepath 'dart',
        'language-server',
        '--protocol=lsp',
      },
      filetypes = { 'dart' },
      init_options = {
        onlyAnalyzeProjectsWithOpenFiles = true,
        suggestFromUnimportedLibraries = true,
        closingLabels = true,
        outline = true,
        flutterOutline = false,
      },
      settings = {
        dart = {
          analysisExcludedFolders = {
            vim.fn.expand '$HOME/.pub-cache/',
            vim.fn.expand '/opt/homebrew/',
            vim.fn.expand '$HOME/development/flutter/',
          },
          updateImportsOnRename = true,
          completeFunctionCalls = true,
          showTodos = true,
        },
      },
    }

    vim.lsp.config('gopls', {
      capabilities = capabilities,
      cmd = { 'gopls' },
      fileTypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
      settings = {
        gopls = {
          completeUnimported = true,
          usePlaceholders = true,
          analyses = {
            unusedparams = true,
          },
        },
      },
    })

    vim.lsp.config('ruff', {
      capabilities = capabilities,
      cmd = { 'ruff', 'server' },
      fileTypes = { 'python' },
      root_markers = { 'pyproject.toml', 'ruff.toml', '.ruff.toml' },
    })

    vim.lsp.config('pyright', {
      settings = {
        pyright = {
          disableOrganizeImports = true,
        },
        python = {
          analysis = {
            ignore = { '*' },
          },
        },
      },
    })

    vim.lsp.config('kotlin_lsp', {
      capabilities = capabilities,
      cmd = { 'kotlin-lsp', '--stdio' },
      fileTypes = { 'kotlin' },
    })

    vim.lsp.config('clangd', {
      capabilities = capabilities,
      fileTypes = { 'c', 'cpp' },
    })
  end,
}
