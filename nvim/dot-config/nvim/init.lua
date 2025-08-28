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
-- ┃ PACK (mini.deps)                                                          ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
local path_package = vim.fn.stdpath('data') .. '/site'
local mini_path = path_package .. '/pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = {
    'git', 'clone', '--filter=blob:none',
    'https://github.com/echasnovski/mini.nvim', mini_path
  }
  vim.fn.system(clone_cmd)
  vim.cmd('packadd mini.nvim | helptags ALL')
  vim.cmd('echo "Installed `mini.nvim`" | redraw')
end
require('mini.deps').setup({ path = { package = path_package } })

local add = MiniDeps.add -- replace with vim.pack.add, once neovim 0.12 lands
add({ source = 'https://github.com/christoomey/vim-tmux-navigator' })
add({ source = 'https://github.com/echasnovski/mini.nvim' })
add({ source = 'https://github.com/neovim/nvim-lspconfig' })
add({ source = 'https://github.com/saghen/blink.cmp' })
add({ source = 'https://github.com/stevearc/oil.nvim' })
add({ source = 'https://github.com/tpope/vim-fugitive' })
add({
  source = 'https://github.com/nvim-treesitter/nvim-treesitter',
  hooks = { post_checkout = function() vim.cmd('TSUpdate') end },
})

vim.cmd.colorscheme("minisummer")

require('mini.ai').setup()
require('mini.diff').setup()
require('mini.icons').setup()
require('mini.pick').setup()
require('mini.surround').setup()
require('oil').setup({
  skip_confirm_for_simple_edits = true,
  keymaps = {
    -- disable default keymaps which interfere with tmux-navigator
    ["<C-h>"] = false, -- select (horizontal)
    ["<C-l>"] = false, -- refresh
  },
})
require('nvim-treesitter.configs').setup({
  ensure_installed = {
    "helm",
    "json",
    "lua",
    "markdown",
    "markdown_inline",
    "python",
    "terraform",
    "typescript",
    "vim",
    "vimdoc",
    "yaml",
  },
  highlight = {
    enable = true
  }
})

-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃ LSP                                                                       ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
vim.lsp.enable("cssls")
vim.lsp.enable("jsonls")
vim.lsp.enable("lua_ls")
vim.lsp.enable("pyright")
vim.lsp.enable("terraformls")
vim.lsp.enable("ts_ls")
vim.lsp.enable("helm_ls")

-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃ KEYMAP                                                                    ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
vim.keymap.set("n", "-", "<cmd>Oil<cr>")

vim.keymap.set("n", "<leader><space>", "<cmd>Pick files<cr>")
vim.keymap.set("n", "<leader>b", "<cmd>Pick buffers<cr>")
vim.keymap.set("n", "<leader>/", "<cmd>Pick grep_live<cr>")
vim.keymap.set("n", "<leader>h", "<cmd>Pick help<cr>")

vim.keymap.set("n", "<leader>g", "<cmd>Git<cr>")

vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>q", "<cmd>qa<cr>")

vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>")

-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃ AUTOCMD                                                                   ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
-- LSP format on save
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = ev.buf,
      callback = function()
        vim.lsp.buf.format { async = false, id = ev.data.client_id }
      end,
    })
  end
})
-- LSP completion
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    assert(client ~= nil)
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end
})
-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.hl.on_yank()
  end,
})
