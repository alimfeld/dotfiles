return {
  -- https://github.com/saghen/blink.cmp
  "saghen/blink.cmp",
  dependencies = "rafamadriz/friendly-snippets",
  version = "*",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    signature = { enabled = true },
  },
}
