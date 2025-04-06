return {
  'saghen/blink.cmp',
  dependencies = {
    {
      'L3MON4D3/LuaSnip',
      dependencies = {
        'rafamadriz/friendly-snippets',
        config = function()
          require('luasnip.loaders.from_vscode').lazy_load()
          require('luasnip.loaders.from_vscode').lazy_load { paths = { vim.fn.stdpath 'config' .. '/snippets' } }
        end,
      },
      version = 'v2.*',
      build = 'make install_jsregexp',
    },
    'xzbdmw/colorful-menu.nvim',
  },
  version = '1.*',
  opts = {
    snippets = { preset = 'luasnip' },
    keymap = {
      preset = 'default',
      ['<C-k>'] = { 'select_prev', 'fallback' },
      ['<C-j>'] = { 'select_next', 'fallback' },
      ['<CR>'] = { 'accept', 'fallback' },
    },
    completion = {
      accept = { auto_brackets = { enabled = true } },
      menu = {
        border = 'rounded',
        draw = {
          columns = {
            { 'label', gap = 1 },
            { 'kind_icon', 'kind', gap = 1 },
          },
          components = {
            label = {
              width = { fill = true, max = 60 },
              text = function(ctx)
                local highlights_info = require('colorful-menu').blink_highlights(ctx)
                if highlights_info ~= nil then
                  return highlights_info.label
                else
                  return ctx.label
                end
              end,
              highlight = function(ctx)
                local highlights = {}
                local highlights_info = require('colorful-menu').blink_highlights(ctx)
                if highlights_info ~= nil then
                  highlights = highlights_info.highlights
                end
                for _, idx in ipairs(ctx.label_matched_indices) do
                  table.insert(highlights, { idx, idx + 1, group = 'BlinkCmpLabelMatch' })
                end
                return highlights
              end,
            },
          },
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 500,
        window = { border = 'rounded' },
      },
    },
    signature = { enabled = true },
    appearance = { nerd_font_variant = 'mono' },
    sources = { default = { 'lsp', 'snippets', 'path', 'buffer' } },
    fuzzy = { implementation = 'prefer_rust_with_warning' },
    enabled = function()
      local disabled_filetypes = { 'NvimTree' }
      return not vim.tbl_contains(disabled_filetypes, vim.bo.filetype)
    end,
  },
  opts_extend = { 'sources.default' },
}
