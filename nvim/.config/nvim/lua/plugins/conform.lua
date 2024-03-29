return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  opts = {
    notify_on_error = false,
    format_on_save = {
      timeout_ms = 1000,
      async = false,
      lsp_fallback = true,
    },
    formatters_by_ft = {
      go = { "gofmt" },
      javascript = { "prettier" },
      json = { "prettier" },
      lua = { "stylua" },
      markdown = { "prettier" },
      python = { "isort", "black" },
      terraform = { "terraform_fmt" },
      yaml = { "prettier" },
    },
  },
}
