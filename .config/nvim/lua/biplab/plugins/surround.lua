return {
  'kylechui/nvim-surround',
  event = 'VeryLazy',
  version = '^3.0.0', -- Use for stability; omit to use `main` branch for the latest features
  config = function()
    require('nvim-surround').setup {}
  end,
}
