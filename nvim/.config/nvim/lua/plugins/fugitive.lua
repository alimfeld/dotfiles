return {
  "tpope/vim-fugitive",
  event = { "VeryLazy" },
  config = function()
    vim.keymap.set("n", "<leader>gg", ":Git<CR>", { desc = "Git" })
  end,
}
