-- cmp
local cmp = require('cmp')
cmp.setup({
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'buffer' },
        { name = 'path' },
    })
})
cmp.setup.cmdline(':', {
  sources = {
    { name = 'cmdline' }
  }
})
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

-- colorscheme
vim.cmd([[colorscheme gruvbox-material]])

-- gitsign
require('gitsigns').setup()

-- lualine
require('lualine').setup {
    options = {
        theme= 'gruvbox-material'
    }
}

-- nvim-tree
require'nvim-tree'.setup()

-- nvim-treeitter
require'nvim-treesitter'.setup()
