return {
  'gbprod/substitute.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local substitute = require 'substitute'
    local exchange = require 'substitute.exchange'

    substitute.setup()

    local keymap = vim.keymap

    keymap.set('n', 's', substitute.operator, { desc = 'Substitute with motion' })
    keymap.set('n', 'ss', substitute.line, { desc = 'Substitute line' })
    keymap.set('n', 'S', substitute.eol, { desc = 'Substitute to end of line' })
    keymap.set('x', 's', substitute.visual, { desc = 'Substitute in visual mode' })

    keymap.set('n', 'cx', exchange.operator, { noremap = true })
    keymap.set('n', 'cxx', exchange.line, { noremap = true })
    keymap.set('x', 'cX', exchange.visual, { noremap = true })
    keymap.set('n', 'cxc', exchange.cancel, { noremap = true })
  end,
}
