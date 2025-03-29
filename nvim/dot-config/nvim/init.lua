vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.number = true
vim.opt.relativenumber = true
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

vim.keymap.set("n", "<leader>q", "<cmd>qa<cr>", { desc = "Quit all" })
vim.keymap.set("v", "<", "<gv", { desc = "Shift left retaining selection" })
vim.keymap.set("v", ">", ">gv", { desc = "Shift right retaining selection" })
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

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

vim.diagnostic.config({ virtual_text = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.hl.on_yank()
  end,
})
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    if client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    end
  end,
})

-- Bootstrap lazy.nvim (see https://lazy.folke.io/installation)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
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
        "netrwPlugin",
        "rplugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
