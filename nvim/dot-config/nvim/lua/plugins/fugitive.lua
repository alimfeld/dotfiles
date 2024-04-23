return {
  "tpope/vim-fugitive",
  event = "VeryLazy",
  keys = {
    { "<leader>gs", "<cmd>Git<CR>", desc = "Git status" },
    { "<leader>gl", "<cmd>Gclog<CR>", desc = "Git log" },
    { "<leader>df", "<cmd>Gvdiffsplit<CR>", desc = "Diff file" },
  },
}
