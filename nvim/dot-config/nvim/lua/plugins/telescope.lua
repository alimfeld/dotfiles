return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-telescope/telescope-live-grep-args.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
  },
  event = "VeryLazy",
  config = function()
    local telescope = require("telescope")

    telescope.setup({
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown(),
        },
      },
    })

    telescope.load_extension("fzf")
    telescope.load_extension("live_grep_args")
    telescope.load_extension("ui-select")

    local builtin = require("telescope.builtin")

    vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
    vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Find Diagnostics" })
    vim.keymap.set("n", "<leader>fc", builtin.commands, { desc = "Find Commands" })
    vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find Help" })
    vim.keymap.set("n", "<leader>fg", builtin.git_files, { desc = "Find Git Files" })
    vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "Find Old Files" })
    vim.keymap.set("n", "<leader><space>", builtin.buffers, { desc = "Find Buffers" })
    vim.keymap.set("n", "<leader>*", builtin.grep_string, { desc = "Find Word" })
    vim.keymap.set("n", "<leader>/", telescope.extensions.live_grep_args.live_grep_args, { desc = "Find by Grep" })

    vim.keymap.set("n", "<leader>fn", function()
      builtin.find_files({ cwd = vim.fn.stdpath("config") })
    end, { desc = "Find Neovim config files" })

    local pickers = require("telescope.pickers")
    local finders = require("telescope.finders")
    local themes = require("telescope.themes")
    local sorters = require("telescope.sorters")
    local journal = function(opts)
      local now = os.time()
      local results = {}
      for i = 1, 7 do
        local time = now - (i - 1) * 3600 * 24
        results[i] = { index = i, weekday = os.date("%A", time), date = os.date("%Y-%m-%d", time) }
      end
      opts = opts or themes.get_dropdown()
      pickers
        .new(opts, {
          prompt_title = "Journal",
          finder = finders.new_table({
            results = results,
            entry_maker = function(entry)
              local path = vim.fn.expand("~/journal/" .. entry.date .. ".md")
              local readable = vim.fn.filereadable(path)
              local indicator = ""
              if readable == 1 then
                indicator = require("nvim-web-devicons").get_icon("markdown", "md")
              end
              local display = string.format("%d: %-10s - %s   %s", entry.index, entry.weekday, entry.date, indicator)
              return {
                value = entry,
                display = display,
                ordinal = display,
                path = path,
              }
            end,
          }),
          sorter = sorters.get_substr_matcher(),
        })
        :find()
    end

    vim.keymap.set("n", "<leader>j", journal, { desc = "Find journal daily" })
  end,
}
