return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-telescope/telescope-live-grep-args.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
  },
  config = function()
    local telescope = require("telescope")

    telescope.setup({
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown(),
        },
        file_browser = {
          initial_mode = "normal",
        },
      },
    })

    telescope.load_extension("fzf")
    telescope.load_extension("live_grep_args")
    telescope.load_extension("file_browser")
    telescope.load_extension("ui-select")

    local builtin = require("telescope.builtin")

    vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "Find files" })
    vim.keymap.set("n", "<leader>t", builtin.builtin, { desc = "Telescope builtins" })
    vim.keymap.set("n", "<leader>w", builtin.grep_string, { desc = "Grep string" })
    vim.keymap.set("n", "<leader>g", telescope.extensions.live_grep_args.live_grep_args, { desc = "Live grep" })
    vim.keymap.set("n", "<leader>d", builtin.diagnostics, { desc = "Diagnostics" })
    vim.keymap.set("n", "<leader><space>", builtin.buffers, { desc = "Buffers" })
    vim.keymap.set("n", "<leader>/", function()
      builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
        winblend = 10,
        previewer = false,
      }))
    end, { desc = "Fuzzy find in buffer" })

    vim.keymap.set("n", "<leader>.", telescope.extensions.file_browser.file_browser, { desc = "File browser" })
  end,
}
