return {
  {
    lazy = true,
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        theme = "gruvbox",
        globalstatus = true,
      }
    }
  },
  {
    "nvim-tree/nvim-tree.lua",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<C-n>", ":NvimTreeFindFileToggle<CR>", { desc = "Toggle tree" } }
    },
    opts = {
      view = {
        adaptive_size = true
      }
    }
  }
}
