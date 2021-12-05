-- cmp
local cmp = require'cmp'
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
require'gitsigns'.setup()

-- lualine
require'lualine'.setup {
    options = {
        theme= 'gruvbox-material'
    }
}

-- nvim-tree
require'nvim-tree'.setup()

-- nvim-treeitter
require'nvim-treesitter'.setup()

-- dap-install
local dap_install = require'dap-install'
local dbg_list = require'dap-install.api.debuggers'.get_installed_debuggers()

for _, debugger in ipairs(dbg_list) do
	dap_install.config(debugger)
end

-- Comment
require'Comment'.setup()
