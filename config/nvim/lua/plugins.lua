-- cmp
local cmp = require('cmp')
require'cmp'.setup({
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
    })
})

-- colorscheme
vim.cmd([[colorscheme gruvbox]])

-- gitsign
require('gitsigns').setup()

-- lualine
require('lualine').setup()

-- nvim-tree
require'nvim-tree'.setup()

-- nvim-treeitter
require'nvim-treesitter'.setup()
