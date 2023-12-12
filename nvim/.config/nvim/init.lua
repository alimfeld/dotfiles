vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.netrw_banner = 0

vim.o.clipboard = "unnamedplus"
vim.o.completeopt = "menuone,noselect"
vim.o.ignorecase = true
vim.o.mouse = "a"
vim.o.smartcase = true
vim.o.termguicolors = true
vim.o.undofile = true
vim.o.updatetime = 250
vim.o.laststatus = 3 -- global statusline

vim.wo.number = true
vim.wo.signcolumn = "yes"
vim.wo.wrap = false

-- Shift left/right retaining selection in visual mode
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Moving lines and preserving indentation
vim.keymap.set("n", "<A-j>", ":move .+1<CR>==")
vim.keymap.set("n", "<A-k>", ":move .-2<CR>==")
vim.keymap.set("v", "<A-j>", ":move '>+1<CR>gv=gv")
vim.keymap.set("v", "<A-k>", ":move '<-2<CR>gv=gv")

-- Re-center after scrolling
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Clear search with <esc>
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Quit
vim.keymap.set("n", "<leader>q", "<cmd>qa<cr>", { desc = "Quit all" })

-- Windows
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

vim.keymap.set("n", "<C-A-l>", [[<cmd>vertical resize +5<cr>]])
vim.keymap.set("n", "<C-A-h>", [[<cmd>vertical resize -5<cr>]])
vim.keymap.set("n", "<C-A-j>", [[<cmd>horizontal resize +2<cr>]])
vim.keymap.set("n", "<C-A-k>", [[<cmd>horizontal resize -2<cr>]])

-- Scratch
vim.keymap.set("n", "gs", "<cmd>e $HOME/scratch.md<cr>", { desc = "Goto scratch" })

-- Filetype
vim.filetype.add({
  extension = {
    puml = "plantuml",
  },
})

-- Lazy
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
    version = false,
  },
  change_detection = {
    enabled = false,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

-- Colorscheme
vim.cmd("colorscheme gruvbox")
