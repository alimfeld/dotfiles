return {
  "tpope/vim-fugitive",
  keys = {
    { "<leader>gg", "<cmd>Git<cr>", desc = "Git" },
    { "<leader>gd", "<cmd>Gvdiffsplit<cr>", desc = "Diff" },
    { "<leader>gb", "<cmd>Git blame<cr>", desc = "Blame" },
    { "<leader>gr", "<cmd>0Gclog<cr>", desc = "Log" },
  },
}
