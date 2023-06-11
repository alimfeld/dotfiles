return {
  {
    "nvim-telescope/telescope.nvim",
    event = "VeryLazy",
    branch = "0.1.x",
    dependencies = {
      "nvim-telescope/telescope-live-grep-args.nvim"
    },
    config = function()
      local telescope = require("telescope")
      telescope.load_extension("live_grep_args")
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find file" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffer" })
      vim.keymap.set("n", "<leader>fp", telescope.extensions.live_grep_args.live_grep_args, { desc = "Find pattern" })
      vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Find diagnostics" })
    end,
  },
}
