return {
  -- https://github.com/stevearc/oil.nvim
  "stevearc/oil.nvim",
  keys = {
    { "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
  },
  opts = {
    skip_confirm_for_simple_edits = true,
    keymaps = {
      -- disable default keymaps which interfere with tmux-navigator
      ["<C-h>"] = false, -- select (horizontal)
      ["<C-l>"] = false, -- refresh
    },
  },
}
