return {
  'catppuccin/nvim',
  name = 'catppuccin',
  lazy = false,
  priority = 1000,
  config = function()
    require('catppuccin').setup {
      flavour = 'mocha',
      transparent_background = false,
      integrations = {
        aerial = true,
        blink_cmp = true,
        fidget = true,
        harpoon = true,
        mason = true,
        copilot_vim = false,
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { 'italic' },
            hints = { 'italic' },
            warnings = { 'italic' },
            information = { 'italic' },
            ok = { 'italic' },
          },
          underlines = {
            errors = { 'underline' },
            hints = { 'underline' },
            warnings = { 'underline' },
            information = { 'underline' },
            ok = { 'underline' },
          },
          inlay_hints = {
            background = true,
          },
        },
        nvim_surround = false,
        lsp_trouble = true,
      },
    }

    vim.cmd [[colorscheme catppuccin]]

    local bg_transparent = false

    local toggle_transparency = function()
      bg_transparent = not bg_transparent
      require('catppuccin').setup {
        transparent_background = bg_transparent,
      }
      vim.cmd [[colorscheme catppuccin]]
    end

    vim.keymap.set('n', '<leader>bg', toggle_transparency, { noremap = true, silent = true })
  end,
}
