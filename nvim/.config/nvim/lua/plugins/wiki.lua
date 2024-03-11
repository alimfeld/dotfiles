return {
  "lervag/wiki.vim",
  config = function()
    vim.g.wiki_root = "~/wiki"
    vim.g.wiki_link_creation = {
      _ = {
        link_type = "wiki",
        url_extension = "",
      },
    }
    vim.keymap.set("n", "<leader>wo", "<cmd>WikiPages<cr>", { desc = "Wiki open" })
  end,
}
