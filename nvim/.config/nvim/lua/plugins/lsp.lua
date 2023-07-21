return {
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    config = true,
  },
  {
    "neovim/nvim-lspconfig",
    version = false,
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function()
          vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0, desc = "Hover" })
          -- <c>ode
          vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = 0, desc = "Code action" })
          vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { buffer = 0, desc = "Rename" })
          -- vim.keymap.set("n", "<leader>cf", function()
          --   vim.lsp.buf.format { async = true }
          -- end, { buffer = 0, desc = "Format" })
        end,
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      require("mason-lspconfig").setup()
      require("mason-lspconfig").setup_handlers {
        function(server_name)
          require("lspconfig")[server_name].setup {
            capabilities = capabilities,
          }
        end,
        ["lua_ls"] = function()
          require("lspconfig").lua_ls.setup {
            capabilities = capabilities,
            settings = {
              Lua = {
                runtime = {
                  version = "LuaJIT",
                },
                diagnostics = {
                  globals = { "vim" },
                },
                telemetry = {
                  enable = false,
                },
              },
            },
          }
        end
      }
    end,
  },
}
