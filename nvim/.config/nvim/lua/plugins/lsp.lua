return {
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    config = true,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function()
          vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0, desc = "Hover" })
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0, desc = "Declaration" })
          vim.keymap.set("n", "gK", vim.lsp.buf.signature_help, { buffer = 0, desc = "Signature help" })
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0, desc = "Definition" })
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = 0, desc = "Implementation" })
          vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = 0, desc = "References" })
          vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, { buffer = 0, desc = "Type definition" })

          vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = 0, desc = "Code action" })
          vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { buffer = 0, desc = "Rename" })
          vim.keymap.set("n", "<leader>cf", function()
            vim.lsp.buf.format { async = true }
          end, { buffer = 0, desc = "Format" })
        end,
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("mason-lspconfig").setup()
      require("mason-lspconfig").setup_handlers {
        function(server_name)
          require("lspconfig")[server_name].setup {}
        end,
        ["lua_ls"] = function()
          require("lspconfig").lua_ls.setup {
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
