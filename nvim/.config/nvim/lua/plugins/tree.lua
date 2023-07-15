return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  cmd = "Neotree",
  keys = {
    {
      "<leader>e",
      function()
        require("neo-tree.command").execute({
          toggle = true,
        })
      end,
      desc = "Explorer",
    },
  },
  opts = {
    filesystem = {
      follow_current_file = true,
      use_libuv_file_watcher = true,
    }
  },
}
