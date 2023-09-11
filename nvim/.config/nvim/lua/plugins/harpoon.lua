return {
  "ThePrimeagen/harpoon",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  event = { "VeryLazy" },
  config = function()
    vim.keymap.set("n", "<leader>hh", require("harpoon.ui").toggle_quick_menu, { desc = "Toggle quick menu" })
    vim.keymap.set("n", "<leader>ha", require("harpoon.mark").add_file, { desc = "Add file" })
    vim.keymap.set("n", "<leader>j", function()
      require("harpoon.ui").nav_file(1)
    end, { desc = "Nav file 1" })
    vim.keymap.set("n", "<leader>k", function()
      require("harpoon.ui").nav_file(2)
    end, { desc = "Nav file 2" })
    vim.keymap.set("n", "<leader>l", function()
      require("harpoon.ui").nav_file(3)
    end, { desc = "Nav file 3" })
    vim.keymap.set("n", "<leader>;", function()
      require("harpoon.ui").nav_file(4)
    end, { desc = "Nav file 4" })
  end,
}
