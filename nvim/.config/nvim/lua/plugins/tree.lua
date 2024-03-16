return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    {
      "<leader>tt",
      "<cmd>NvimTreeFindFileToggle<CR>",
      desc = "Toggle tree",
    },
  },
  opts = {
    view = {
      adaptive_size = true,
    },
    update_focused_file = {
      enable = true,
    },
  },
}
