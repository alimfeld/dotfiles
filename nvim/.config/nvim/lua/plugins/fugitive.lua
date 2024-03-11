return {
  "tpope/vim-fugitive",
  keys = {
    { "<leader>gg", "<cmd>Git<cr>", desc = "Git" },
    { "<leader>gd", "<cmd>Gvdiffsplit!<cr>", desc = "Diff" },
    { "<leader>gb", "<cmd>Git blame<cr>", desc = "Blame" },
    { "<leader>gl", "<cmd>0Gclog<cr>", desc = "Log" },
    { "<leader>gp", "<cmd>Git pull<cr>", desc = "Pull" },
    { "<leader>gP", "<cmd>Git push<cr>", desc = "Push" },
  },
}
