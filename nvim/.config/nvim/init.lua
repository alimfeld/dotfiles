-- {{{ Globals

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- }}}

-- {{{ Options

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.scrolloff = 999

vim.opt.wrap = false

vim.opt.clipboard = "unnamedplus"

vim.opt.completeopt = "menu,menuone,noinsert,noselect"

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true

vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true
vim.opt.laststatus = 3 -- global statusline

vim.opt.timeoutlen = 300
vim.opt.updatetime = 250

vim.opt.undofile = true

-- }}}

-- {{{ Keymaps

-- Quit
vim.keymap.set("n", "<leader>q", "<cmd>qa<cr>", { desc = "Quit all" })

-- Error messages
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic error messages" })

-- Next/Previous mappings (unimpaired / bracketed)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Diagnostic message" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Diagnostic message" })
vim.keymap.set("n", "]q", "<cmd>cnext<cr>", { desc = "Quickfix item" })
vim.keymap.set("n", "[q", "<cmd>cprevious<cr>", { desc = "Quickfix item" })
vim.keymap.set("n", "]Q", "<cmd>clast<cr>", { desc = "Quickfix item (last)" })
vim.keymap.set("n", "[Q", "<cmd>cfirst<cr>", { desc = "Quickfix item (first)" })

-- Shift left/right retaining selection in visual mode
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Moving lines and preserving indentation
vim.keymap.set("n", "<A-j>", ":move .+1<CR>==")
vim.keymap.set("n", "<A-k>", ":move .-2<CR>==")
vim.keymap.set("v", "<A-j>", ":move '>+1<CR>gv=gv")
vim.keymap.set("v", "<A-k>", ":move '<-2<CR>gv=gv")

-- Clear search with <esc>
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Resize splits
vim.keymap.set("n", "<C-A-l>", [[<cmd>vertical resize +5<cr>]])
vim.keymap.set("n", "<C-A-h>", [[<cmd>vertical resize -5<cr>]])
vim.keymap.set("n", "<C-A-j>", [[<cmd>horizontal resize +2<cr>]])
vim.keymap.set("n", "<C-A-k>", [[<cmd>horizontal resize -2<cr>]])

-- }}}

-- {{{ Filetype

vim.filetype.add({
  extension = {
    puml = "plantuml",
    tf = "terraform",
  },
})

-- }}}

-- {{{ Autocommands

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- }}}

-- {{{ Plugins

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
  change_detection = {
    enabled = false,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "man",
        "matchit",
        "rplugin",
        "tarPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

-- }}}
