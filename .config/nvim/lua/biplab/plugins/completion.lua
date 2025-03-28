return {
  {
    'saghen/blink.cmp',
    dependencies = { {
      'L3MON4D3/LuaSnip',
      version = 'v2.*',
    } },
    version = '1.*',
    opts = {
      keymap = {
        preset = 'default',
        ['<C-k>'] = { 'select_prev', 'fallback' },
        ['<C-j>'] = { 'select_next', 'fallback' },
      },
      appearance = {
        nerd_font_variant = 'mono',
      },
      completion = { documentation = { auto_show = false } },
      snippets = { preset = 'luasnip' },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
      fuzzy = { implementation = 'prefer_rust_with_warning' },
    },
    opts_extend = { 'sources.default' },
    config = function()
      require('blink.cmp').setup {
        completion = {
          menu = {
            draw = {
              columns = { { 'kind_icon' }, { 'label', gap = 1 } },
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
        },
      }
    end,
  },
  {
    'xzbdmw/colorful-menu.nvim',
    config = function()
      -- You don't need to set these options.
      require('colorful-menu').setup {
        ls = {
          lua_ls = {
            arguments_hl = '@comment',
          },
          gopls = {
            align_type_to_right = true,
            add_colon_before_type = false,
            preserve_type_when_truncate = true,
          },
          clangd = {
            extra_info_hl = '@comment',
            align_type_to_right = true,
            import_dot_hl = '@comment',
            preserve_type_when_truncate = true,
          },
          zls = {
            align_type_to_right = true,
          },
          roslyn = {
            extra_info_hl = '@comment',
          },
          dartls = {
            extra_info_hl = '@comment',
          },
          fallback = true,
          fallback_extra_info_hl = '@comment',
        },
        fallback_highlight = '@variable',
        max_width = 60,
      }
    end,
  },
}
