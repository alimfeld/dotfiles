return {
  "iamcco/markdown-preview.nvim",
  ft = "markdown",
  build = "cd app && yarn install",
  keys = {
    { "<leader>m", ":MarkdownPreview<CR>", desc = "Markdown Preview" },
  },
}
