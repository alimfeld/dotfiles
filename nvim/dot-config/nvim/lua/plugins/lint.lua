return {
  -- https://github.com/mfussenegger/nvim-lint
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("lint").linters_by_ft = {
      sh = { "shellcheck" },
      python = { "pylint" },
    }
    vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}
