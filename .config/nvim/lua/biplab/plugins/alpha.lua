return {
  'goolord/alpha-nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },

  config = function()
    local alpha = require 'alpha'
    local dashboard = require 'alpha.themes.startify'

    dashboard.section.header.val = {
      [[                                                                       ]],
      [[        ████ ██████           █████      ██                      ]],
      [[       ███████████             █████                              ]],
      [[       █████████ ███████████████████ ███   ███████████    ]],
      [[      █████████  ███    █████████████ █████ ██████████████    ]],
      [[     █████████ ██████████ █████████ █████ █████ ████ █████    ]],
      [[   ███████████ ███    ███ █████████ █████ █████ ████ █████   ]],
      [[  ██████  █████████████████████ ████ █████ █████ ████ ██████  ]],
    }
    dashboard.section.header.opts = {
      position = 'center',
      hl = 'AlphaHeader',
    }

    alpha.setup(dashboard.opts)

    vim.api.nvim_set_hl(0, 'AlphaHeader', { fg = '#89b4fa' })
    vim.api.nvim_set_hl(0, 'AlphaButtons', { fg = '#a6e3a1' })
    vim.api.nvim_set_hl(0, 'AlphaFooter', { fg = '#b4befe' })
  end,
}
