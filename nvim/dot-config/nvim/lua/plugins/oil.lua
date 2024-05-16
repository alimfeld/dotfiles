return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
  },
  opts = {
    keymaps = {
      -- disable keymaps which interfere with tmux-navigator
      ["<C-h>"] = false,
      ["<C-l>"] = false,
    },
  },
}
