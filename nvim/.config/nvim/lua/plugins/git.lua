return {
  {
    "tpope/vim-fugitive",
    event = { "VeryLazy" },
    config = function()
      vim.keymap.set("n", "<leader>gg", ":Git<CR>", { desc = "Git" })
    end,
  },
  {
    "sindrets/diffview.nvim",
    event = { "VeryLazy" },
    config = function()
      vim.keymap.set("n", "<leader>gf", ":DiffviewFileHistory %<CR>", { desc = "File history" })
      vim.keymap.set("n", "<leader>gF", ":DiffviewFileHistory<CR>", { desc = "Files history" })
      vim.keymap.set("n", "<leader>gd", ":DiffviewOpen<CR>", { desc = "Diff" })
      vim.keymap.set("n", "<leader>gD", ":DiffviewOpen HEAD<CR>", { desc = "Diff HEAD" })
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = {
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "]c", function()
          if vim.wo.diff then
            return "]c"
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return "<Ignore>"
        end, { expr = true, desc = "Next hunk" })

        map("n", "[c", function()
          if vim.wo.diff then
            return "[c"
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return "<Ignore>"
        end, { expr = true, desc = "Previous hunk" })

        -- Actions
        map("n", "<leader>gb", function()
          gs.blame_line({ full = true })
        end, { desc = "Blame line" })
        map("n", "<leader>gtb", gs.toggle_current_line_blame, { desc = "Toggle current line blame" })
        map("n", "<leader>gtd", gs.toggle_deleted, { desc = "Toggle deleted" })

        -- Text object
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
      end,
    },
  },
}
