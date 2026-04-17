-- =============================================================================
-- CORE
-- =============================================================================

-- -----------------------------------------------------------------------------
-- Options
-- -----------------------------------------------------------------------------

-- tabs and indentation
vim.opt.shiftwidth = 4
vim.opt.softtabstop = -1
vim.opt.expandtab = true
-- splits
vim.opt.splitbelow = true
vim.opt.splitright = true
-- clipboard
vim.opt.clipboard = "unnamedplus"
-- completion
vim.opt.completeopt = "menu,menuone,noinsert,noselect"
-- cursor
vim.opt.scrolloff = 999
vim.opt.cursorline = true
-- wrap
vim.opt.wrap = false
-- UI
vim.opt.number = true
vim.opt.pumborder = "rounded"
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true
vim.opt.winborder = "rounded"
-- search
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- whitespace
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
-- statusline
vim.opt.laststatus = 3
-- timeouts
vim.opt.timeoutlen = 300
vim.opt.updatetime = 250
-- undo
vim.opt.undofile = true
-- project local config
vim.opt.exrc = true

-- -----------------------------------------------------------------------------
-- Leader key
-- -----------------------------------------------------------------------------

vim.g.mapleader = " "

-- -----------------------------------------------------------------------------
-- General key mappings
-- -----------------------------------------------------------------------------

vim.keymap.set("n", "<leader>q", "<cmd>qa<cr>", { desc = "Quit All" })
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", {
  desc = "Clear search highlight on escape",
})

-- -----------------------------------------------------------------------------
-- Filetype mappings
-- -----------------------------------------------------------------------------

vim.filetype.add({
  pattern = {
    [".*/templates/.*%.yaml"] = "helm",
    [".*/*-templates/.*%.yaml"] = "helm",
    ["helmfile.yaml"] = "helm",
  },
})

-- -----------------------------------------------------------------------------
-- Diagnostic config
-- -----------------------------------------------------------------------------

vim.diagnostic.config({ virtual_text = true })

-- -----------------------------------------------------------------------------
-- Highlight on yank
-- -----------------------------------------------------------------------------

vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function() vim.hl.on_yank() end,
  desc = "Briefly highlight yanked text"
})

-- -----------------------------------------------------------------------------
-- UI2 (experimental)
-- -----------------------------------------------------------------------------

require('vim._core.ui2').enable({}) -- No "Press ENTER" messages

-- =============================================================================
-- PLUGINS
-- =============================================================================

-- -----------------------------------------------------------------------------
-- Treesitter
-- -----------------------------------------------------------------------------

vim.pack.add({ 'https://github.com/nvim-treesitter/nvim-treesitter' })

local parsers = {
  "helm",
  "json",
  "python",
  "terraform",
  "typescript",
  "yaml",
}

require('nvim-treesitter').install(parsers)

-- -----------------------------------------------------------------------------
-- LSP
-- -----------------------------------------------------------------------------

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

-- -----------------------------------------------------------------------------
-- Git
-- -----------------------------------------------------------------------------

vim.pack.add({ 'https://github.com/tpope/vim-fugitive' })

vim.keymap.set("n", "<leader>g", "<cmd>Git<cr>", { desc = "Git Status" })

-- -----------------------------------------------------------------------------
-- GitHub Copilot
-- -----------------------------------------------------------------------------

vim.pack.add({ 'https://github.com/github/copilot.vim' })

-- -----------------------------------------------------------------------------
-- Tmux Navigator
-- -----------------------------------------------------------------------------

vim.pack.add({ 'https://github.com/christoomey/vim-tmux-navigator' })

vim.g.tmux_navigator_preserve_zoom = 1 -- don't unzoom tmux pane when navigating
vim.g.tmux_navigator_no_wrap = 1       -- don't wrap around the screen

-- -----------------------------------------------------------------------------
-- Colorscheme
-- -----------------------------------------------------------------------------

vim.pack.add({ { src = 'https://github.com/catppuccin/nvim', name = 'catppuccin' } })

vim.cmd.colorscheme("catppuccin")

-- -----------------------------------------------------------------------------
-- Mini quality-of-life plugins
-- -----------------------------------------------------------------------------

vim.pack.add({ 'https://github.com/nvim-mini/mini.nvim' })

require('mini.ai').setup()
require('mini.diff').setup()
require('mini.icons').setup()
require('mini.pick').setup({
  mappings = {
    refine        = '<C-j>',
    refine_marked = '<M-j>',

  },
})
require('mini.surround').setup()

vim.keymap.set("n", "<leader><space>", function() MiniPick.builtin.files() end, { desc = "Find File" })
vim.keymap.set("n", "<leader>,", function() MiniPick.builtin.buffers() end, { desc = "Find Buffer" })
vim.keymap.set("n", "<leader>/", function() MiniPick.builtin.grep_live() end, { desc = "Search with Grep" })

-- -----------------------------------------------------------------------------
-- Oil
-- -----------------------------------------------------------------------------

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
