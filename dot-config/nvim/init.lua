vim.o.number = true                      -- show line numbers
vim.o.signcolumn = "yes"                 -- always show the sign column

vim.o.ignorecase = true                  -- ignore case in search patterns
vim.o.smartcase = true                   -- ...unless search pattern contains uppercase letters

vim.o.wrap = false                       -- disable line wrapping
vim.o.list = true                        -- show whitespace characters

vim.o.clipboard = "unnamedplus"          -- use system clipboard

vim.o.cursorline = true                  -- highlight the current line

vim.o.exrc = true                        -- allow project-specific config

vim.o.undofile = true                    -- enable persistent undo

vim.g.mapleader = vim.keycode('<Space>') -- set the leader key to Space

vim.keymap.set("n", "<leader>q", "<cmd>qa<cr>", { desc = "Quit All" })

vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Clear search highlight" })

vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format() end, { desc = "Format Buffer" })

vim.diagnostic.config({ virtual_text = true }) -- show diagnostics as virtual text

require('vim._core.ui2').enable({})            -- No "Press ENTER" messages

vim.cmd.colorscheme("retrobox")

-- nvim-lspconfig & LSP configuration

vim.pack.add({ 'https://github.com/neovim/nvim-lspconfig' })

vim.lsp.enable("bashls")
vim.lsp.enable("cssls")
vim.lsp.enable("helm_ls")
vim.lsp.enable("jsonls")
vim.lsp.enable("lua_ls")
vim.lsp.enable("pyright")
vim.lsp.enable("ruff")
vim.lsp.enable("terraformls")
vim.lsp.enable("ts_ls")

-- vim-fugitive

vim.pack.add({ 'https://github.com/tpope/vim-fugitive' })

vim.keymap.set("n", "<leader>g", "<cmd>Git<cr>", { desc = "Git Status" })

-- copilot.vim

vim.pack.add({ 'https://github.com/github/copilot.vim' })

-- vim-tmux-navigator

vim.pack.add({ 'https://github.com/christoomey/vim-tmux-navigator' })

vim.g.tmux_navigator_preserve_zoom = 1 -- don't unzoom tmux pane when navigating
vim.g.tmux_navigator_no_wrap = 1       -- don't wrap around the screen

-- mini.nvim

vim.pack.add({ 'https://github.com/nvim-mini/mini.nvim' })

require('mini.ai').setup()
require('mini.completion').setup()
require('mini.diff').setup()
require('mini.icons').setup()
require('mini.snippets').setup()
require('mini.surround').setup()

require('mini.pick').setup({
  mappings = {
    refine        = '<C-j>', -- instead of <C-Space> (tmux leader)
    refine_marked = '<M-j>', -- instead of <M-Space>
  },
})

vim.keymap.set("n", "<leader><space>", function() MiniPick.builtin.files() end, { desc = "Find File" })
vim.keymap.set("n", "<leader>,", function() MiniPick.builtin.buffers() end, { desc = "Find Buffer" })
vim.keymap.set("n", "<leader>/", function() MiniPick.builtin.grep_live() end, { desc = "Search with Grep" })

-- oil.nvim

vim.pack.add({ 'https://github.com/stevearc/oil.nvim' })

require('oil').setup({
  skip_confirm_for_simple_edits = true,
  keymaps = {
    -- disable default keymaps which interfere with tmux-navigator
    ["<C-h>"] = false, -- select (horizontal)
    ["<C-l>"] = false, -- refresh
  },
})

vim.keymap.set("n", "-", "<cmd>Oil<cr>", { desc = "Open Parent Directory" })
