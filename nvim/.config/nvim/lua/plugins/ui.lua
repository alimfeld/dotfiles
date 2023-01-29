return {
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme gruvbox]])
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        theme = "gruvbox",
        globalstatus = true,
      }
    }
  },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<C-n>", ":NvimTreeFindFileToggle<CR>", { desc = "Toggle tree" }}
    },
    opts = {
      view = {
        adaptive_size = true
      }
    }
  }
}

