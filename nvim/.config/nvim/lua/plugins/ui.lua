return {
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-tree/nvim-web-devicons"
    },
    opts = {
      options = {
        theme = "gruvbox",
        globalstatus = true,
      },
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      defaults = {
        mode = { "n", "v" },
        ["g"] = { name = "+Goto" },
        ["]"] = { name = "+Next" },
        ["["] = { name = "+Prev" },
        ["<leader>f"] = { name = "+File/Find" },
        ["<leader>s"] = { name = "+Search" },
        ["<leader>c"] = { name = "+Code" },
        ["<leader>h"] = { name = "+Harpoon" },
      }
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      wk.register(opts.defaults)
    end,
  },
}
