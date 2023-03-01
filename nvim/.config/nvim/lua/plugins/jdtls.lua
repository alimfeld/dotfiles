return {
  {
    "mfussenegger/nvim-jdtls",
    lazy = true,
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client.name == "jdtls" then
            local jdtls = require("jdtls")
            vim.keymap.set("n", "<leader>df", jdtls.test_class, { desc = "Test class", buffer = 0 })
            vim.keymap.set("n", "<leader>dn", jdtls.test_nearest_method, { desc = "Test nearest method", buffer = 0 })
          end
        end,
      })
    end,
  },
}
