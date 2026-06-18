-- -----------------------------------------------------------------------------
-- Core
-- -----------------------------------------------------------------------------

-- Leader key
vim.g.mapleader = vim.keycode('<Space>')

-- Options
vim.o.number = true
vim.o.signcolumn = "yes"
vim.o.list = true
vim.o.cursorline = true
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.scrolloff = 10
vim.o.inccommand = "split"
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.exrc = true
vim.o.undofile = true
vim.o.clipboard = "unnamedplus"
vim.o.autocomplete = true
vim.o.complete = "o,.,w,b,u"
vim.o.completeopt = "fuzzy,menuone,noselect,popup"

-- Convenience keymaps
vim.keymap.set("n", "<leader>q", "<cmd>qa<CR>", { desc = "[q]uit all" })
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- Diagnostics
vim.diagnostic.config({ virtual_text = true })
vim.keymap.set("n", "<leader>d", vim.diagnostic.setloclist, { desc = "Open [d]iagnostic quickfix list" })

-- Highlight when yanking
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('my.hl_on_yank', {}),
  callback = function() vim.hl.on_yank() end,
})

-- UI2: No "Press ENTER" messages
require('vim._core.ui2').enable({})

-- Colorscheme
vim.cmd.colorscheme("retrobox")

-- Scratch
vim.keymap.set("n",
  "<leader>s", "<cmd>edit ~/scratch.md | setlocal noswapfile<CR>",
  { desc = "Edit [S]cratch file." }
)

-- -----------------------------------------------------------------------------
-- LSP configuration (nvim-lspconfig)
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

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp', {}),
  callback = function(ev)
    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
    -- Auto-format ("lint") on save.
    -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
    if not client:supports_method('textDocument/willSaveWaitUntil')
        and client:supports_method('textDocument/formatting') then
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
        buffer = ev.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = ev.buf, id = client.id, timeout_ms = 1000 })
        end,
      })
    end
  end,
})

-- -----------------------------------------------------------------------------
-- Git integration (vim-fugitive)
-- -----------------------------------------------------------------------------

vim.pack.add({ 'https://github.com/tpope/vim-fugitive' })

vim.keymap.set("n", "<leader>g", "<cmd>G<CR>", { desc = "Search [b]uffer" })

-- -----------------------------------------------------------------------------
-- Tmux integration (vim-tmux-navigator)
-- -----------------------------------------------------------------------------

vim.pack.add({ 'https://github.com/christoomey/vim-tmux-navigator' })

vim.g.tmux_navigator_preserve_zoom = 1 -- don't unzoom tmux pane when navigating
vim.g.tmux_navigator_no_wrap = 1       -- don't wrap around the screen

-- -----------------------------------------------------------------------------
-- QoL plugins (mini.nvim)
-- -----------------------------------------------------------------------------

vim.pack.add({ 'https://github.com/nvim-mini/mini.nvim' })

require('mini.icons').setup()
require('mini.ai').setup()
require('mini.surround').setup()
require('mini.diff').setup()

require('mini.pick').setup({
  mappings = {
    refine        = '<C-j>', -- instead of <C-Space> (tmux leader)
    refine_marked = '<M-j>', -- instead of <M-Space>
  },
})

vim.keymap.set("n", "<leader><Space>", function() MiniPick.builtin.files({ tool = 'git' }) end, { desc = "Find file" })
vim.keymap.set("n", "<leader>/", function() MiniPick.builtin.grep_live({ tool = 'git' }) end,
  { desc = "Search with grep" })
vim.keymap.set("n", "<leader>b", function() MiniPick.builtin.buffers() end, { desc = "Search [b]uffer" })

-- -----------------------------------------------------------------------------
-- File explorer (oil.nvim)
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
