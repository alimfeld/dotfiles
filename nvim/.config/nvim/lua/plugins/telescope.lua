return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-live-grep-args.nvim",
  },
  event = "VeryLazy",
  config = function()
    local telescope = require("telescope")
    telescope.load_extension("live_grep_args")
    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader><space>", builtin.find_files, { desc = "Files" })
    vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "Buffers" })
    vim.keymap.set("n", "<leader>d", builtin.diagnostics, { desc = "Diagnostics" })
    vim.keymap.set("n", "<leader>s", telescope.extensions.live_grep_args.live_grep_args, { desc = "Search" })
  end,
}
