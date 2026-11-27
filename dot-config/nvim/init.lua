-- -----------------------------------------------------------------------------
-- Core
-- -----------------------------------------------------------------------------

-- Leader key
vim.g.mapleader = vim.keycode('<Space>')

-- Options
vim.o.number = true
vim.o.signcolumn = "yes"
vim.o.wrap = true
vim.o.linebreak = true
vim.o.breakindent = true
vim.o.breakindentopt = "list:-1"
vim.opt.diffopt:append("followwrap") -- diffs keep wrap instead of forcing nowrap
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
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, desc = "Down (screen line without count)" })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, desc = "Up (screen line without count)" })

-- Diagnostics
vim.diagnostic.config({ virtual_text = true })

-- Highlight when yanking
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('my.hl_on_yank', {}),
  callback = function() vim.hl.on_yank() end,
})

-- UI2: No "Press ENTER" messages
require('vim._core.ui2').enable({})

-- Colorscheme
-- Follows background (detected from the terminal), matching Ghostty's light/dark Modus Tinted
vim.pack.add({ 'https://github.com/miikanissi/modus-themes.nvim' })
require('modus-themes').setup({
  transparent = true, -- let tmux's inactive-pane tint show through
  variants = { modus_operandi = 'tinted', modus_vivendi = 'tinted' },
  on_colors = function(c)
    -- operandi tinted's cursorline (#f1d5d0) is indistinguishable from DiffDelete (#f4d0cf)
    if c.bg_hl_line == '#f1d5d0' then c.bg_hl_line = '#dae5ec' end
  end,
})
vim.cmd.colorscheme("modus")

-- Scratch
vim.keymap.set("n",
  "<leader>s", "<cmd>edit $XDG_STATE_HOME/scratch.md | setlocal noswapfile<CR>",
  { desc = "Edit [S]cratch file." }
)

-- -----------------------------------------------------------------------------
-- LSP configuration (nvim-lspconfig)
-- -----------------------------------------------------------------------------

vim.pack.add({ 'https://github.com/neovim/nvim-lspconfig' })

vim.lsp.enable("bashls")
vim.lsp.enable("cssls")
vim.lsp.enable("jsonls")
vim.lsp.enable("lua_ls")
vim.lsp.enable("marksman")
vim.lsp.enable("pyright")
vim.lsp.enable("ruff")
vim.lsp.enable("tsc")

vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "[f]ormat buffer" })

-- -----------------------------------------------------------------------------
-- Treesitter (nvim-treesitter: parsers + queries; highlighting is built in)
-- -----------------------------------------------------------------------------

-- Parsers must match the plugin version, so update them with it.
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    if ev.data.spec.name == 'nvim-treesitter' and ev.data.kind == 'update' then
      if not ev.data.active then vim.cmd.packadd('nvim-treesitter') end
      vim.cmd('TSUpdate')
    end
  end,
})

vim.pack.add({ 'https://github.com/nvim-treesitter/nvim-treesitter' })

-- Languages with an LSP above; lua, markdown and vimdoc ship with Neovim.
require('nvim-treesitter').install({ 'bash', 'css', 'javascript', 'json', 'python', 'tsx', 'typescript' })

vim.api.nvim_create_autocmd('FileType', {
  desc = 'Start treesitter highlighting where a parser exists',
  group = vim.api.nvim_create_augroup('my.treesitter', {}),
  callback = function() pcall(vim.treesitter.start) end,
})

-- -----------------------------------------------------------------------------
-- Git integration (vim-fugitive)
-- -----------------------------------------------------------------------------

vim.pack.add({ 'https://github.com/tpope/vim-fugitive' })

vim.keymap.set("n", "<leader>g", "<cmd>G<CR>", { desc = "[g]it status" })

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

require('mini.ai').setup()
require('mini.extra').setup()
require('mini.diff').setup()
require('mini.icons').setup()
require('mini.surround').setup()

require('mini.pick').setup({
  mappings = {
    refine        = '<C-j>', -- instead of <C-Space> (tmux leader)
    refine_marked = '<M-j>', -- instead of <M-Space>
  },
})
vim.ui.select = MiniPick.ui_select

vim.keymap.set("n", "<leader><Space>", function() MiniPick.builtin.files() end, { desc = "Find file" })
vim.keymap.set("n", "<leader>/", function() MiniPick.builtin.grep_live() end,
  { desc = "Search with grep" })
vim.keymap.set("n", "<leader>b", function() MiniPick.builtin.buffers() end, { desc = "Search [b]uffer" })
vim.keymap.set("n", "<leader>h", function() MiniPick.builtin.help() end, { desc = "Search [h]elp" })
vim.keymap.set("n", "<leader>'", function() MiniPick.builtin.resume() end, { desc = "Resume last picker" })
vim.keymap.set("n", "<leader>d", function() MiniExtra.pickers.diagnostic() end, { desc = "Search [d]iagnostics" })

-- Show pending keymaps after a trigger key
local miniclue = require('mini.clue')
miniclue.setup({
  triggers = {
    { mode = { 'n', 'x' }, keys = '<Leader>' },
    { mode = { 'n', 'x' }, keys = 'g' },
    { mode = { 'n', 'x' }, keys = 'z' },
    { mode = 'n', keys = '[' },
    { mode = 'n', keys = ']' },
    { mode = 'n', keys = '<C-w>' },
    { mode = { 'n', 'x' }, keys = "'" },
    { mode = { 'n', 'x' }, keys = '`' },
    { mode = { 'n', 'x' }, keys = '"' },
    { mode = { 'i', 'c' }, keys = '<C-r>' },
  },
  clues = {
    miniclue.gen_clues.g(),
    miniclue.gen_clues.z(),
    miniclue.gen_clues.square_brackets(),
    miniclue.gen_clues.windows(),
    miniclue.gen_clues.marks(),
    miniclue.gen_clues.registers(),
  },
})

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

-- -----------------------------------------------------------------------------
-- Markdown rendering (render-markdown.nvim)
-- -----------------------------------------------------------------------------

vim.pack.add({ 'https://github.com/MeanderingProgrammer/render-markdown.nvim' })

require('render-markdown').setup({
  anti_conceal = { enabled = false },  -- always render, no raw text on cursor line
  quote = { repeat_linebreak = true }, -- continue quote bar on wrapped lines
})

vim.keymap.set("n", "<leader>m", "<cmd>RenderMarkdown toggle<CR>", { desc = "Toggle [m]arkdown rendering" })
