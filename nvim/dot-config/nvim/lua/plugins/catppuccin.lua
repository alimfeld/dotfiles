return {
  -- https://github.com/catppuccin/nvim
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd("colorscheme catppuccin-macchiato")
  end,
}
