return {
  -- https://github.com/stevearc/conform.nvim
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    format_on_save = function(bufnr)
      -- Disable with a global or buffer-local variable
      -- The values are toggled with Snacks toggle (see ./snacks.lua)
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      return { timeout_ms = 1000, async = false, lsp_fallback = true }
    end,
    formatters_by_ft = {
      css = { "prettier" },
      fish = { "fish_indent" },
      go = { "gofmt" },
      javascript = { "prettier" },
      json = { "prettier" },
      lua = { "stylua" },
      markdown = { "prettier" },
      python = { "isort", "black" },
      terraform = { "terraform_fmt" },
      typescript = { "prettier" },
      xml = { "xmllint" },
      yaml = { "prettier" },
    },
  },
}
