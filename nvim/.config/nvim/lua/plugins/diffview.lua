return {
  "sindrets/diffview.nvim",
  event = { "VeryLazy" },
  config = function()
    vim.keymap.set("n", "<leader>gf", ":DiffviewFileHistory %<CR>", { desc = "File history" })
    vim.keymap.set("n", "<leader>gF", ":DiffviewFileHistory<CR>", { desc = "Files history" })
    vim.keymap.set("n", "<leader>gd", ":DiffviewOpen<CR>", { desc = "Diff" })
    vim.keymap.set("n", "<leader>gD", ":DiffviewOpen HEAD<CR>", { desc = "Diff HEAD" })
  end,
}
