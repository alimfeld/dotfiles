return {
  {
    "nvim-telescope/telescope.nvim",
    event = "VeryLazy",
    branch = "0.1.x",
    config = function()
      local telescope = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", telescope.find_files, { desc = "Find file" })
      vim.keymap.set("n", "<leader>fb", telescope.buffers, { desc = "Find buffer" })
      vim.keymap.set("n", "<leader>fp", telescope.live_grep, { desc = "Find pattern" })
      vim.keymap.set("n", "<leader>fd", telescope.diagnostics, { desc = "Find diagnostics" })
    end,
  },
}
