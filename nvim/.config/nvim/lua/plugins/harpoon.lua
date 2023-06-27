return {
  {
    "ThePrimeagen/harpoon",
    keys = {
      {
        "<leader>hh",
        function()
          require("harpoon.ui").toggle_quick_menu()
        end,
        desc = "Toggle Quick Menu",
      },
      {
        "<leader>ha",
        function()
          require("harpoon.mark").add_file()
        end,
        desc = "Add File",
      },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      defaults = {
        mode = { "n", "v" },
        ["<leader>h"] = { name = "+harpoon" },
      },
    },
  },
}
