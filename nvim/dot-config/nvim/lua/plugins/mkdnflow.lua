return {
  "jakewvincent/mkdnflow.nvim",
  ft = "markdown",
  config = function()
    require("mkdnflow").setup({
      mappings = {
        MkdnToggleToDo = { { "n", "v" }, "<leader>c" },
      },
    })
  end,
}
