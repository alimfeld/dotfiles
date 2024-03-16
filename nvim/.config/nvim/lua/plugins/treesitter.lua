return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("nvim-treesitter.configs").setup({
      modules = {},
      ensure_installed = {},
      sync_install = false,
      auto_install = true,
      ignore_install = {},
      highlight = { enable = true, additional_vim_regex_highlighting = false },
    })
  end,
}
