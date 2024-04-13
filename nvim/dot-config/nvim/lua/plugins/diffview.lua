return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewFileHistory" },
  keys = {
    { "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", desc = "Git File History" },
    { "<leader>gi", "<cmd>DiffviewOpen<CR>", desc = "Git Diff Index" },
  },
  config = true,
}
