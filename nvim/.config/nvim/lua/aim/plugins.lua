require("which-key").setup()

require("gitsigns").setup()

require("Comment").setup()

require("lualine").setup({
  options = {
    theme = "gruvbox",
    globalstatus = true,
  },
})

require("gruvbox").setup()
vim.cmd([[colorscheme gruvbox]])

require("nvim-treesitter.configs").setup({
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>a"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>A"] = "@parameter.inner",
      },
    },
  },
})

local telescope_builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>sf", telescope_builtin.find_files, { desc = "Search file" })
vim.keymap.set("n", "<leader>sb", telescope_builtin.buffers, { desc = "Search buffer" })
vim.keymap.set("n", "<leader>sp", telescope_builtin.live_grep, { desc = "Search pattern" })
vim.keymap.set("n", "<leader>sd", telescope_builtin.diagnostics, { desc = "Search diagnostics" })

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local dap = require("dap")
    vim.keymap.set("n", "<C-p>", dap.toggle_breakpoint, { desc = "Toggle breakpoint", buffer = 0 })
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if (client.name == 'jdtls') then
      local jdtls = require("jdtls")
      vim.keymap.set("n", "<leader>oi", jdtls.organize_imports, { desc = "Organize imports", buffer = 0 })
      vim.keymap.set("n", "<leader>df", jdtls.test_class, { desc = "Test class", buffer = 0 })
      vim.keymap.set("n", "<leader>dn", jdtls.test_nearest_method, { desc = "Test nearest method", buffer = 0 })
    end
  end,
})

local lsp = require('lsp-zero')
lsp.preset('recommended')
lsp.nvim_workspace()
lsp.build_options("jdtls")
lsp.setup()

require("mason-null-ls").setup({ automatic_setup = true })
require("mason-null-ls").setup_handlers({})
require("null-ls").setup()
require("mason-nvim-dap").setup({ automatic_setup = true })
require("mason-nvim-dap").setup_handlers({})
