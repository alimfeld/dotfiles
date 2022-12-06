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

local cmp = require("cmp")
local luasnip = require("luasnip")
cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete({}),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
  },
})

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
    vim.keymap.set("n", "gd", telescope_builtin.lsp_definitions, { desc = "Goto definitions", buffer = 0 })
    vim.keymap.set("n", "gr", telescope_builtin.lsp_references, { desc = "Goto references", buffer = 0 })
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if (client.name == 'jdtls') then
      local jdtls = require("jdtls")
      vim.keymap.set("n", "<leader>oi", jdtls.organize_imports, { desc = "Organize imports", buffer = 0 })
      vim.keymap.set("n", "<leader>df", jdtls.test_class, { desc = "Test class", buffer = 0 })
      vim.keymap.set("n", "<leader>dn", jdtls.test_nearest_method, { desc = "Test nearest method", buffer = 0 })
    end
  end,
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("mason").setup()

require("mason-null-ls").setup({ automatic_setup = true })
require("mason-null-ls").setup_handlers({})

require("null-ls").setup()

require("mason-lspconfig").setup()
require("mason-lspconfig").setup_handlers({
  function(lsp)
    require("lspconfig")[lsp].setup({
      capabilities = capabilities,
    })
  end,
  ["jdtls"] = function()
    -- do nothing... jdtls setup is handled by nvim-jdtls
  end,
  ["sumneko_lua"] = function()
    require("lspconfig").sumneko_lua.setup({
      capabilities = capabilities,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
        },
      },
    })
  end,
})

require("mason-nvim-dap").setup({ automatic_setup = true })
require("mason-nvim-dap").setup_handlers({})
