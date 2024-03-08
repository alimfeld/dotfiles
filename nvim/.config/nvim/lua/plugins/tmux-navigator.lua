return {
  "christoomey/vim-tmux-navigator",
  keys = {
    { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>", desc = "Jump to the window on the left" },
    { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>", desc = "Jump to the window below" },
    { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>", desc = "Jump to the window above" },
    { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>", desc = "Jump to the window on the right" },
    { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>", desc = "Jump to the previous window" },
  },
  config = function()
    vim.g.tmux_navigator_preserve_zoom = 1
    vim.g.tmux_navigator_no_wrap = 1
  end,
}
