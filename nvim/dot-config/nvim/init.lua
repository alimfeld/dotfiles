vim.o.clipboard = "unnamedplus"
vim.o.completeopt = "menu,menuone,noinsert,noselect"
vim.o.cursorline = true
vim.o.exrc = true
vim.o.list = true
vim.o.number = true
vim.o.signcolumn = "yes"
vim.o.undofile = true

vim.g.mapleader = " "

vim.keymap.set("n", "<leader>q", "<cmd>qa<cr>", { desc = "Quit All" })
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", {
  desc = "Clear search highlight on escape",
})

vim.diagnostic.config({ virtual_text = true })

require('vim._core.ui2').enable({}) -- No "Press ENTER" messages

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

-- see :help lsp-format
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp', {}),
  callback = function(ev)
    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))

    -- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
    if client:supports_method('textDocument/completion') then
      -- Optional: trigger autocompletion on EVERY keypress. May be slow!
      -- local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
      -- client.server_capabilities.completionProvider.triggerCharacters = chars

      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end

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
require('mini.diff').setup()
require('mini.icons').setup()
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
