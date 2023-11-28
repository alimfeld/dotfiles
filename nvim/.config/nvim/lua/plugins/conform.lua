return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")
    conform.setup({
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "isort", "black" },
        markdown = { "prettier" },
        yaml = { "prettier" },
        json = { "prettier" },
        terraform = { "terraform_fmt" },
        go = { "gofmt" },
        xml = { "xmlformat" },
      },
    })
    vim.keymap.set({ "n", "v" }, "<leader>f", conform.format, { desc = "Format" })
  end,
}
