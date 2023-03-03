vim.g.mapleader = " "
vim.g.maplocalleader = " "

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
vim.wo.signcolumn = "yes"

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Shift left/right retaining selection in visual mode
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Navigate quickfix list
vim.keymap.set("n", "<C-.>", ":cn<CR>", { desc = "Next item in quickfix list" })
vim.keymap.set("n", "<C-,>", ":cp<CR>", { desc = "Previous item in quickfix list" })

vim.keymap.set("n", "gs", ":e $HOME/scratch.md<CR>", { desc = "Goto scratch" })

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function()
    vim.keymap.set("n", "<leader>jf", vim.lsp.buf.format, { desc = "Format", buffer = 0 })
    vim.keymap.set("n", "<leader>jn", vim.lsp.buf.rename, { desc = "Rename", buffer = 0 })
    vim.keymap.set("n", "<leader>ja", vim.lsp.buf.code_action, { desc = "Code action", buffer = 0 })
  end,
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")

vim.cmd([[colorscheme gruvbox]])
