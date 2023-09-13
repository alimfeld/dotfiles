return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-live-grep-args.nvim",
    },
    event = "VeryLazy",
    config = function()
      local telescope = require("telescope")
      local action_state = require("telescope.actions.state")
      local function diff(template)
        -- Open in diffview
        local selected_entry = action_state.get_selected_entry()
        local value = selected_entry.value
        -- close Telescope window properly prior to switching windows
        vim.api.nvim_win_close(0, true)
        vim.cmd("stopinsert")
        vim.schedule(function()
          vim.cmd((template):format(value))
        end)
      end
      telescope.setup({
        pickers = {
          git_commits = {
            mappings = {
              i = {
                ["<M-d>"] = function()
                  diff("DiffviewOpen %s^!")
                end,
              },
            },
          },
          git_branches = {
            mappings = {
              i = {
                ["<M-d>"] = function()
                  diff("DiffviewOpen %s")
                end,
              },
            },
          },
        },
      })
      telescope.load_extension("live_grep_args")
      local builtin = require("telescope.builtin")
      -- <f>ind (file)
      vim.keymap.set("n", "<leader><space>", builtin.find_files, { desc = "Files" })
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Files" })
      vim.keymap.set("n", "<leader>fh", function()
        builtin.find_files({ hidden = true })
      end, { desc = "Hidden files" })
      vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Recent files" })
      -- <b>uffers
      vim.keymap.set("n", "<leader>bb", builtin.buffers, { desc = "Buffers" })
      -- <s>earch
      vim.keymap.set("n", "<leader>sb", builtin.git_branches, { desc = "Branches" })
      vim.keymap.set("n", "<leader>sc", builtin.git_commits, { desc = "Commits" })
      vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "Diagnostics" })
      vim.keymap.set("n", "<leader>sg", telescope.extensions.live_grep_args.live_grep_args, { desc = "Grep" })
      vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "Help tags" })
      vim.keymap.set("n", "<leader>sq", builtin.quickfix, { desc = "Quickfix" })
      -- LSP
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function()
          -- <g>oto
          vim.keymap.set("n", "gd", builtin.lsp_definitions, { buffer = 0, desc = "Definitions" })
          vim.keymap.set("n", "gr", builtin.lsp_references, { buffer = 0, desc = "References" })
          vim.keymap.set("n", "gi", builtin.lsp_implementations, { buffer = 0, desc = "Implementations" })
        end,
      })
    end,
  },
}
