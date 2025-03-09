return {
  -- https://github.com/folke/which-key.nvim
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    spec = {
      {
        "<leader>f",
        group = "Find",
      },
      {
        "<leader>s",
        group = "Search",
      },
      {
        "<leader>g",
        group = "Git",
      },
      {
        "<leader>t",
        group = "Toggle",
      },
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
