return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = true,

  vim.keymap.set('n', '<leader>tt', '<cmd>ToggleTerm direction=float size=50<CR>', { desc = 'Launch floating terminal' }),
}
