return {
  'mg979/vim-visual-multi',
  branch = 'master',
  init = function()
    vim.g.VM_maps = {
      ['Add Cursor Down'] = '<C-S-j>',
      ['Add Cursor Up'] = '<C-S-k>',
    }
  end,
  -- TODO: Find a way to change keymappings for this plugin

  -- config = function()
  --   vim.keymap.set('n', 'C-S-j', '<Plug>(VM-Add-Cursor-Down)')
  -- end,
}
