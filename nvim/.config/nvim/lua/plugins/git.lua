return {
  {
    "tpope/vim-fugitive",
    event = { "VeryLazy" },
  },
  {
    "sindrets/diffview.nvim",
    event = { "VeryLazy" },
    config = function()
      vim.keymap.set("n", "<leader>gh", ":DiffviewFileHistory ~<CR>", { desc = "Git filehistory" })
      vim.keymap.set("n", "<leader>gH", ":DiffviewFileHistory<CR>", { desc = "Git history" })
    end
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
        map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "Toggle current line blame" })
        map("n", "<leader>gd", gs.diffthis, { desc = "Diff" })
        map("n", "<leader>gD", function()
          gs.diffthis("~")
        end, { desc = "Diff HEAD" })
        map("n", "<leader>td", gs.toggle_deleted, { desc = "Toggle deleted" })

        -- Text object
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
      end,
    },
  },
}
