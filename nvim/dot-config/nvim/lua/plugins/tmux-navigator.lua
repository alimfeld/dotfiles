return {
  -- https://github.com/christoomey/vim-tmux-navigator
  "christoomey/vim-tmux-navigator",
  keys = {
    { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>", desc = "Jump to the window on the left" },
    { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>", desc = "Jump to the window below" },
    { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>", desc = "Jump to the window above" },
    { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>", desc = "Jump to the window on the right" },
  },
  config = function()
    vim.g.tmux_navigator_preserve_zoom = 1 -- don't unzoom tmux pane when navigating
    vim.g.tmux_navigator_no_wrap = 1 -- don't wrap around the screen
  end,
}
