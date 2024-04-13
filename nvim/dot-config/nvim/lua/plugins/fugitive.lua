return {
  "tpope/vim-fugitive",
  event = "VeryLazy",
  keys = {
    { "<leader>gs", "<cmd>Git<CR>", desc = "Git Status" },
    { "<leader>gd", "<cmd>Gvdiffsplit<CR>", desc = "Git Diff" },
  },
}
