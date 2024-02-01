return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")
    conform.setup({
      formatters_by_ft = {
        go = { "gofmt" },
        javascript = { "prettier" },
        json = { "prettier" },
        lua = { "stylua" },
        markdown = { "prettier" },
        python = { "isort", "black" },
        terraform = { "terraform_fmt" },
        xml = { "xmlformat" },
        yaml = { "prettier" },
      },
    })
    vim.keymap.set({ "n", "v" }, "<leader>f", conform.format, { desc = "Format" })
  end,
}
