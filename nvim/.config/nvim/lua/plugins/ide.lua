return {
  {
    'VonHeikemen/lsp-zero.nvim',
    event = "VeryLazy",
    branch = 'v1.x',
    dependencies = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' }, -- Required
      { 'williamboman/mason.nvim' }, -- Optional
      { 'williamboman/mason-lspconfig.nvim' }, -- Optional

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' }, -- Required
      { 'hrsh7th/cmp-nvim-lsp' }, -- Required
      { 'hrsh7th/cmp-buffer' }, -- Optional
      { 'hrsh7th/cmp-path' }, -- Optional
      { 'saadparwaiz1/cmp_luasnip' }, -- Optional
      { 'hrsh7th/cmp-nvim-lua' }, -- Optional

      -- Snippets
      { 'L3MON4D3/LuaSnip' }, -- Required
      { 'rafamadriz/friendly-snippets' }, -- Optional
    },
    config = function()
      local lsp = require('lsp-zero')
      lsp.preset('recommended')
      lsp.set_preferences({
        set_lsp_keymaps = { omit = { "<C-k>" } }
      })
      lsp.nvim_workspace()
      lsp.build_options("jdtls")
      lsp.setup()
    end
  },
  {
    "mfussenegger/nvim-jdtls",
    event = "VeryLazy",
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if (client.name == 'jdtls') then
            local jdtls = require("jdtls")
            vim.keymap.set("n", "<leader>ji", jdtls.organize_imports, { desc = "Organize imports", buffer = 0 })
            vim.keymap.set("n", "<leader>df", jdtls.test_class, { desc = "Test class", buffer = 0 })
            vim.keymap.set("n", "<leader>dn", jdtls.test_nearest_method, { desc = "Test nearest method", buffer = 0 })
          end
        end,
      })
    end
  },
  {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    dependencies = { "jayp0521/mason-nvim-dap.nvim" },
    config = function()
      require("mason-nvim-dap").setup({ automatic_setup = true })
      require("mason-nvim-dap").setup_handlers({})
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function()
          local dap = require("dap")
          vim.keymap.set("n", "<F5>", dap.continue, { desc = "Continue", buffer = 0 })
          vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Step over", buffer = 0 })
          vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Step into", buffer = 0 })
          vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Step out", buffer = 0 })
          vim.keymap.set("n", "<Leader>b", dap.toggle_breakpoint, { desc = "Toggle breakpoint", buffer = 0 })
          vim.keymap.set("n", "<Leader>B", function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
            { desc = "Set conditional breakpoint", buffer = 0 })
          vim.keymap.set("n", "<Leader>dr", dap.repl.open, { desc = "Open a REPL", buffer = 0 })
          vim.keymap.set("n", "<Leader>dl", dap.run_last, { desc = "Run last", buffer = 0 })
        end,
      })
    end
  },
}
