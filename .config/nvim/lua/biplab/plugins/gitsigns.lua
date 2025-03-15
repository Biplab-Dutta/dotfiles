return {
  'lewis6991/gitsigns.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local gitsigns = require 'gitsigns'

    gitsigns.setup {
      current_line_blame = true,
    }

    local function keymap(mode, l, r, desc)
      vim.keymap.set(mode, l, r, { desc = desc })
    end

    -- Navigation
    keymap('n', ']h', gitsigns.next_hunk, 'Next Hunk')
    keymap('n', '[h', gitsigns.prev_hunk, 'Prev Hunk')

    -- Actions
    keymap('n', '<leader>ga', gitsigns.stage_hunk, 'Stage hunk')
    keymap('n', '<leader>gr', gitsigns.reset_hunk, 'Reset hunk')
    keymap('n', '<leader>gA', gitsigns.stage_buffer, 'Stage buffer')
    keymap('n', '<leader>gR', gitsigns.reset_buffer, 'Reset buffer')
    keymap('n', '<leader>gu', gitsigns.undo_stage_hunk, 'Undo stage hunk')
    keymap('n', '<leader>gp', gitsigns.preview_hunk, 'Preview hunk')
    keymap('n', '<leader>gb', gitsigns.toggle_current_line_blame, 'Toggle line blame')
    keymap('n', '<leader>gd', gitsigns.diffthis, 'Diff this')
    keymap('v', '<leader>ga', function()
      gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
    end, 'Stage hunk')
    keymap('v', '<leader>gr', function()
      gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
    end, 'Reset hunk')
    keymap('n', '<leader>gB', function()
      gitsigns.blame_line { full = true }
    end, 'Blame line')
    keymap('n', '<leader>gD', function()
      gitsigns.diffthis '~'
    end, 'Diff this ~')

    -- Text object
    keymap({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', 'Gitsigns select hunk')
  end,
}
