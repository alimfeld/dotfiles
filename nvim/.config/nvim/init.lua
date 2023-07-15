vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.o.breakindent = true
vim.o.clipboard = "unnamedplus"
vim.o.completeopt = "menuone,noselect"
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

-- Clear search with <esc>
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

vim.keymap.set("n", "gs", ":e $HOME/scratch.md<CR>", { desc = "Goto scratch" })

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

require("lazy").setup("plugins", {
  defaults = {
    lazy = true,
  },
  change_detection = {
    enabled = false,
  },
})

vim.cmd([[colorscheme gruvbox]])
