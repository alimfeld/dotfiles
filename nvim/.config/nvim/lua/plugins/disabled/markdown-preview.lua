return {
  "iamcco/markdown-preview.nvim",
  build = "cd app && yarn install",
  ft = "markdown",
  keys = {
    { "<leader>m", ":MarkdownPreview<CR>", desc = "Preview markdown" },
  },
}
