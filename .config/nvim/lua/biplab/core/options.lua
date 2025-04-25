vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt_local.number = true
vim.opt.mouse = 'a'
vim.opt.clipboard = 'unnamedplus'
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt_local.signcolumn = 'yes'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.completeopt = 'menuone,noselect'
vim.opt.termguicolors = true
vim.opt.whichwrap = 'bs<>[]hl'
vim.opt.wrap = false
vim.opt.linebreak = true
vim.opt.scrolloff = 4
vim.opt.sidescrolloff = 8
vim.opt.relativenumber = true
vim.opt.numberwidth = 4
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.cursorline = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.smartindent = true
vim.opt.showmode = false
vim.opt.showtabline = 2
vim.opt.backspace = 'indent,eol,start'
vim.opt.pumheight = 10
vim.opt.conceallevel = 0
vim.opt.fileencoding = 'utf-8'
vim.opt.cmdheight = 1
vim.opt.autoindent = true
vim.opt.shortmess:append 'c'
vim.opt.iskeyword:append '-'
vim.opt.formatoptions:remove { 'c', 'r', 'o' }
vim.opt.runtimepath:remove '/usr/share/vim/vimfiles'

vim.opt.foldcolumn = '0'
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldtext = ''
vim.opt.foldnestmax = 3
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99

local function close_all_folds()
  vim.api.nvim_exec2('%foldc!', { output = false })
end
local function open_all_folds()
  vim.api.nvim_exec2('%foldo!', { output = false })
end

vim.keymap.set('n', '<leader>zs', close_all_folds, { desc = '[s]hut all folds' })
vim.keymap.set('n', '<leader>zo', open_all_folds, { desc = '[o]pen all folds' })

vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
})
