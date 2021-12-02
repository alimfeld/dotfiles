local opt = vim.opt

-- tabs, indent
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true

-- search
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

-- clipboard
opt.clipboard = 'unnamedplus'

-- completion
opt.completeopt = 'menuone,noselect'

-- ui
opt.number = true
opt.relativenumber = true
opt.showmatch = true
opt.visualbell = true
opt.wrap = false
opt.splitbelow = true
opt.splitright = true
opt.background = 'dark'
local map = vim.api.nvim_set_keymap
local g = vim.g

local function noremap(mode, lhs, rhs)
    map(mode, lhs, rhs, { noremap = true })
end


-- leader
noremap('n', '<Space>', '<Nop>')
g.mapleader = ' '

-- mappings for navigating splits
noremap('n', '<C-j>', '<C-w><C-j>')
noremap('n', '<C-k>', '<C-w><C-k>')
noremap('n', '<C-l>', '<C-w><C-l>')
noremap('n', '<C-h>', '<C-w><C-h>')

-- mappings for moving lines
noremap('n', '<A-j>', ':m .+1<CR>==')
noremap('n', '<A-k>', ':m .-2<CR>==')
noremap('i' ,'<A-j>', '<Esc>:m .+1<CR>==gi')
noremap('i' ,'<A-k>', '<Esc>:m .-2<CR>==gi')
noremap('v', '<A-j>', ':m \'>+1<CR>gv=gv')
noremap('v', '<A-k>', ':m \'<-2<CR>gv=gv')
