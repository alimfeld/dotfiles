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
