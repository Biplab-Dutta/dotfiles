return {
  'ibhagwan/fzf-lua',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    local fzf = require 'fzf-lua'

    fzf.setup {
      { 'telescope' },
      keymap = {
        builtin = {
          ['<C-u>'] = 'preview-page-up',
          ['<C-d>'] = 'preview-page-down',
        },
        fzf = {
          ['ctrl-k'] = 'up',
          ['ctrl-j'] = 'down',
          ['ctrl-q'] = 'abort',
        },
      },
      files = {
        fd_opts = '--type f --hidden --exclude node_modules --exclude .git --exclude .venv',
        previewer = 'builtin',
      },
      buffers = {
        sort_lastused = true,
        previewer = 'builtin',
      },
      grep = {
        cmd = 'rg --line-number --column --no-heading --color=always --smart-case',
        rg_opts = '--hidden --glob "!node_modules/*" --glob "!.git/*" --glob "!.venv/*"',
        previewer = 'builtin',
      },
      live_grep = {
        cmd = 'rg --line-number --column --no-heading --color=always --smart-case',
        rg_opts = '--hidden --glob "!node_modules/*" --glob "!.git/*" --glob "!.venv/*"',
        previewer = 'builtin',
      },
      git = {
        files = {
          previewer = true,
        },
      },
      fzf_opts = {
        ['--tiebreak'] = 'index',
      },
      defaults = {
        git_icons = true,
        file_icons = true,
        color_icons = true,
      },
    }

    local keymap = vim.keymap.set

    keymap('n', '<leader>?', fzf.oldfiles, { desc = '[?] Find recently opened files' })
    keymap('n', '<leader>sb', fzf.buffers, { desc = '[S]earch existing [B]uffers' })
    keymap('n', '<leader>sm', fzf.marks, { desc = '[S]earch [M]arks' })
    keymap('n', '<leader>gf', fzf.git_files, { desc = 'Search [G]it [F]iles' })
    keymap('n', '<leader>gc', fzf.git_commits, { desc = 'Search [G]it [C]ommits' })
    keymap('n', '<leader>gcf', fzf.git_bcommits, { desc = 'Search [G]it [C]ommits for current [F]ile' })
    keymap('n', '<leader>tgb', fzf.git_branches, { desc = 'Search [G]it [B]ranches' })
    keymap('n', '<leader>gs', fzf.git_status, { desc = 'Search [G]it [S]tatus (diff view)' })
    keymap('n', '<leader>ff', fzf.files, { desc = '[S]earch [F]iles' })
    keymap('n', '<leader>sh', fzf.help_tags, { desc = '[S]earch [H]elp' })
    keymap('n', '<leader>scw', fzf.grep_cword, { desc = '[S]earch current [W]ord' })
    keymap('n', '<leader>lg', fzf.live_grep, { desc = '[S]earch by [G]rep' })
    keymap('n', '<leader>sd', fzf.diagnostics_document, { desc = '[S]earch [D]iagnostics' })
    keymap('n', '<leader>sr', fzf.resume, { desc = '[S]earch [R]esume' })
    keymap('n', '<leader>s.', fzf.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
    keymap('n', '<leader>qf', fzf.quickfix, { desc = 'Show quick fix list' })
    keymap('n', '<leader>ft', function()
      fzf.grep { cmd = 'rg --column', search = 'TODO|FIXME|NOTE', prompt = 'Todos> ' }
    end, { desc = 'Find todos' })
    keymap('n', '<leader>sds', function()
      fzf.lsp_document_symbols {
        symbol_types = { 'Class', 'Function', 'Method', 'Constructor', 'Interface', 'Module', 'Property' },
      }
    end, { desc = '[S]each LSP document [S]ymbols' })
    keymap('n', '<leader><leader>', fzf.buffers, { desc = 'Find existing buffers' })
    keymap('n', '<leader>s/', function()
      fzf.live_grep { buffers_only = true, prompt = 'Live Grep in Open Files> ' }
    end, { desc = '[S]earch [/] in Open Files' })
    keymap('n', '<leader>/', function()
      fzf.blines { previewer = false }
    end, { desc = 'Fuzzily search in current buffer' })
  end,
}
