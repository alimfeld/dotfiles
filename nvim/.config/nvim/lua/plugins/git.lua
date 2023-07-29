return {
  {
    "tpope/vim-fugitive",
    event = { "VeryLazy" },
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = true,
  },
}
