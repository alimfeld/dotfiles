return {
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    opts = {
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
        end, { expr = true })

        map("n", "[c", function()
          if vim.wo.diff then
            return "[c"
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return "<Ignore>"
        end, { expr = true })

        -- Actions
        map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>", { desc = "stage hunk" })
        map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>", { desc = "reset hunk" })
        map("n", "<leader>hS", gs.stage_buffer, { desc = "stage buffer" })
        map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "undo stage hunk" })
        map("n", "<leader>hR", gs.reset_buffer, { desc = "reset buffer" })
        map("n", "<leader>hp", gs.preview_hunk, { desc = "preview hunk" })
        map("n", "<leader>hb", function()
          gs.blame_line({ full = true })
        end, { desc = "blame line" })
        map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "toggle line blame" })
        map("n", "<leader>hd", gs.diffthis, { desc = "diff against index" })
        map("n", "<leader>hD", function()
          gs.diffthis("~")
        end, { desc = "diff against parent" })
        map("n", "<leader>td", gs.toggle_deleted, { desc = "toggle deleted" })

        -- Text object
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
      end,
    },
  },
}
