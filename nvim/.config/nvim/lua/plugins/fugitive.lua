return {
  "tpope/vim-fugitive",
  event = { "VeryLazy" },
  config = function()
    vim.keymap.set("n", "<leader>g", ":Git<CR>", { desc = "Git" })
  end,
}
