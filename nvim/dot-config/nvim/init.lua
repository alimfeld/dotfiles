-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃ GLOBAL                                                                    ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.tmux_navigator_preserve_zoom = 1 -- don't unzoom tmux pane when navigating
vim.g.tmux_navigator_no_wrap = 1       -- don't wrap around the screen

-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃ OPTION                                                                    ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

vim.opt.number = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.scrolloff = 999
vim.opt.wrap = false
vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = "menu,menuone,noinsert,noselect"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.inccommand = "split"
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true
vim.opt.laststatus = 3 -- global statusline
vim.opt.timeoutlen = 300
vim.opt.updatetime = 250
vim.opt.undofile = true
vim.opt.winborder = "rounded"
vim.opt.termguicolors = true
vim.opt.exrc = true -- enable per-project .nvim.lua, .nvimrc or .exrc

-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃ FILETYPE                                                                  ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

vim.filetype.add({
  extension = {
    puml = "plantuml",
  },
  pattern = {
    [".*/templates/.*%.yaml"] = "helm",
    [".*/*-templates/.*%.yaml"] = "helm",
    ["helmfile.yaml"] = "helm",
  },
})

-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃ PACK                                                                      ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

vim.pack.add({
  { src = 'https://github.com/catppuccin/nvim', name = 'catppuccin' },
  'https://github.com/christoomey/vim-tmux-navigator',
  'https://github.com/echasnovski/mini.nvim',
  'https://github.com/folke/snacks.nvim',
  'https://github.com/folke/which-key.nvim',
  'https://github.com/github/copilot.vim',
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/nvim-treesitter/nvim-treesitter',
  'https://github.com/stevearc/oil.nvim',
  'https://github.com/tpope/vim-fugitive',
})

-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃ COLOR                                                                     ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

vim.cmd.colorscheme("catppuccin")

-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃ SETUP                                                                     ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

require('mini.ai').setup()
require('mini.diff').setup()
require('mini.icons').setup()
require('mini.surround').setup()

require('oil').setup({
  skip_confirm_for_simple_edits = true,
  keymaps = {
    -- disable default keymaps which interfere with tmux-navigator
    ["<C-h>"] = false, -- select (horizontal)
    ["<C-l>"] = false, -- refresh
  },
})

require('snacks').setup({
  explorer = { enabled = true },
  picker = { enabled = true },
  toggle = { enabled = true },
})

local parsers = {
  "helm",
  "json",
  "lua",
  "markdown",
  "markdown_inline",
  "python",
  "regex",
  "terraform",
  "typescript",
  "vim",
  "vimdoc",
  "yaml",
}

require 'nvim-treesitter'.install(parsers)

vim.api.nvim_create_autocmd('FileType', {
  pattern = parsers,
  callback = function() vim.treesitter.start() end,
})

-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃ LSP                                                                       ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

vim.lsp.enable("bashls")
vim.lsp.enable("cssls")
vim.lsp.enable("helm_ls")
vim.lsp.enable("jsonls")
vim.lsp.enable("lua_ls")
vim.lsp.enable("pyright")
vim.lsp.enable("ruff")
vim.lsp.enable("terraformls")
vim.lsp.enable("ts_ls")

-- LSP features (see :help lsp)
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp', {}),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    -- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
    if client:supports_method('textDocument/completion') then
      -- Optional: trigger autocompletion on EVERY keypress. May be slow!
      -- local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
      -- client.server_capabilities.completionProvider.triggerCharacters = chars
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    end
    -- Auto-format ("lint") on save.
    -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
    if not client:supports_method('textDocument/willSaveWaitUntil')
        and client:supports_method('textDocument/formatting') then
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
        end,
      })
    end
  end,
})

-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃ DIAGNOSTIC                                                                ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

vim.diagnostic.config({ virtual_text = true })

-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃ KEYMAP                                                                    ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

vim.keymap.set("n", "<leader>q", "<cmd>qa<cr>", { desc = "Quit All" })
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>")
-- Top Pickers & Explorer
vim.keymap.set("n", "<leader><space>", function() Snacks.picker.smart() end, { desc = "Smart Find File" })
vim.keymap.set("n", "<leader>,", function() Snacks.picker.buffers() end, { desc = "Find Buffer" })
vim.keymap.set("n", "<leader>/", function() Snacks.picker.grep() end, { desc = "Search with Grep" })
vim.keymap.set("n", "<leader>:", function() Snacks.picker.command_history() end, { desc = "Search Command History" })
vim.keymap.set("n", "<leader>e", function() Snacks.picker.explorer() end, { desc = "File Explorer" })
vim.keymap.set("n", "-", "<cmd>Oil<cr>", { desc = "Open Parent Directory" })
-- Git
vim.keymap.set("n", "<leader>g", "<cmd>Git<cr>", { desc = "Git Status" })
-- Search
vim.keymap.set("n", "<leader>sd", function() Snacks.picker.diagnostics() end, { desc = "Diagnostics" })
vim.keymap.set("n", "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, { desc = "Buffer Diagnostics" })
vim.keymap.set("n", "<leader>sh", function() Snacks.picker.help() end, { desc = "Help Pages" })
-- Pack
vim.keymap.set("n", "<leader>pu", function() vim.pack.update() end, { desc = "Update packages" })

-- Register groups
require("which-key").add({
  { "<leader>s", group = "Search" },
  { "<leader>w", proxy = "<c-w>", group = "Windows" },
  { "<leader>u", group = "Toggle" },
  { "<leader>p", group = "Pack" },
})

Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")

-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃ VARIOUS                                                                   ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup('my.hl', {}),
  callback = function()
    vim.hl.on_yank()
  end,
})
