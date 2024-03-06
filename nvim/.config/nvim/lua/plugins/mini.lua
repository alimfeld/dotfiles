return {
  "echasnovski/mini.nvim",
  version = false,
  config = function()
    require("mini.ai").setup()

    require("mini.surround").setup()

    require("mini.comment").setup()

    require("mini.completion").setup()

    require("mini.statusline").setup({
      set_vim_settings = false,
    })
  end,
}
