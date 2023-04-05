return {
  {
    "VonHeikemen/lsp-zero.nvim",
    event = "VeryLazy",
    branch = "v1.x",
    dependencies = {
      -- LSP Support
      { "neovim/nvim-lspconfig" }, -- Required
      { "williamboman/mason.nvim" }, -- Optional
      { "williamboman/mason-lspconfig.nvim" }, -- Optional

      -- null-ls
      { "jose-elias-alvarez/null-ls.nvim" },
      { "jay-babu/mason-null-ls.nvim" },

      -- format
      { "lukas-reineke/lsp-format.nvim" },

      -- Autocompletion
      { "hrsh7th/nvim-cmp" }, -- Required
      { "hrsh7th/cmp-nvim-lsp" }, -- Required
      { "hrsh7th/cmp-buffer" }, -- Optional
      { "hrsh7th/cmp-path" }, -- Optional
      { "saadparwaiz1/cmp_luasnip" }, -- Optional
      { "hrsh7th/cmp-nvim-lua" }, -- Optional

      -- Snippets
      { "L3MON4D3/LuaSnip" }, -- Required
      { "rafamadriz/friendly-snippets" }, -- Optional
    },
    config = function()
      -- lsp-zero setup
      local lsp = require("lsp-zero").preset({
        name = "minimal",
        set_lsp_keymaps = { preserve_mappings = false, omit = { "<C-k>" } },
        manage_nvim_cmp = true,
        suggest_lsp_servers = false,
      })
      lsp.on_attach(function(client, _)
        require("lsp-format").on_attach(client)
      end)
      lsp.nvim_workspace()
      lsp.skip_server_setup({ "jdtls" })
      lsp.setup()
      -- diagnostics
      vim.diagnostic.config({
        virtual_text = true,
      })

      -- null-ls setup
      local null_ls = require("null-ls")
      local null_opts = lsp.build_options("null-ls", {})
      null_ls.setup({
        on_attach = function(client, bufnr)
          local format_cmd = function(input)
            vim.lsp.buf.format({
              id = client.id,
              timeout_ms = 5000,
              async = input.bang,
            })
          end

          local bufcmd = vim.api.nvim_buf_create_user_command
          bufcmd(bufnr, "NullLsFormat", format_cmd, {
            bang = true,
            range = true,
            desc = "Format using null-ls",
          })
          null_opts.on_attach(client, bufnr)
        end,
      })
      require("mason-null-ls").setup({ automatic_setup = true })
      require("mason-null-ls").setup_handlers()
    end,
  },
}
