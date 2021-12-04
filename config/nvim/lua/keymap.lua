local map = vim.api.nvim_set_keymap

-- leader
vim.g.mapleader = ' '
map('n', '<Space>', '<Nop>', {noremap = true})

-- split navigation
-- map('n', '<C-j>', '<C-w><C-j>', {noremap = true})
-- map('n', '<C-k>', '<C-w><C-k>', {noremap = true})
-- map('n', '<C-l>', '<C-w><C-l>', {noremap = true})
-- map('n', '<C-h>', '<C-w><C-h>', {noremap = true})

-- Telescope
map('n', '<leader>ff', '<cmd>Telescope find_files<cr>', {noremap=true})
map('n', '<leader>fg', '<cmd>Telescope git_files<cr>',  {noremap=true})
map('n', '<leader>fr', '<cmd>Telescope live_grep<cr>',  {noremap=true})
map('n', '<leader>fb', '<cmd>Telescope buffers<cr>',    {noremap=true})
map('n', '<leader>fh', '<cmd>Telescope help_tags<cr>',  {noremap=true})

-- NvimTree
map('n', '<C-n>', ':NvimTreeToggle<CR>', {noremap = true})

-- Neoformat
map('n', 'F', ':Neoformat<CR>', {noremap = true})
