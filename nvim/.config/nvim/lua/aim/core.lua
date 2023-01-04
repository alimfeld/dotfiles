vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.netrw_banner = 0

vim.o.breakindent = true
vim.o.clipboard = "unnamedplus"
vim.o.completeopt = "menuone,noselect"
vim.o.hlsearch = false
vim.o.ignorecase = true
vim.o.mouse = "a"
vim.o.smartcase = true
vim.o.termguicolors = true
vim.o.undofile = true
vim.o.updatetime = 250

vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.signcolumn = "yes"

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "gs", ":e $HOME/scratch.md<CR>", { desc = "Goto scratch" })

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function()
    vim.keymap.set("n", "<leader>jf", vim.lsp.buf.format, { desc = "Format", buffer = 0 })
    vim.keymap.set("n", "<leader>jn", vim.lsp.buf.rename, { desc = "Rename", buffer = 0 })
    vim.keymap.set("n", "<leader>ja", vim.lsp.buf.code_action, { desc = "Code action", buffer = 0 })
  end,
})
