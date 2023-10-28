return {
  "neovim/nvim-lspconfig",
  config = function()
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function()
        vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0, desc = "Hover" })
        -- <c>ode
        vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = 0, desc = "Code action" })
        vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { buffer = 0, desc = "Rename" })
        -- vim.keymap.set("n", "<leader>cf", function()
        --   vim.lsp.buf.format({ async = true })
        -- end, { buffer = 0, desc = "Format" })
      end,
    })
  end,
}
