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
      },
    },
  },
  {
    "nvim-tree/nvim-tree.lua",
    keys = {
      { "<C-n>", ":NvimTreeFindFileToggle<CR>", { desc = "Toggle tree" } },
    },
    opts = {
      view = {
        adaptive_size = true,
      },
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "VeryLazy",
    config = true,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = true,
  },
}
