return {
  {
    "mfussenegger/nvim-dap",
    lazy = true,
    dependencies = { "jayp0521/mason-nvim-dap.nvim" },
    config = function()
      require("mason-nvim-dap").setup({ automatic_setup = true })
      require("mason-nvim-dap").setup_handlers({})
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function()
          local dap = require("dap")
          vim.keymap.set("n", "<F5>", dap.continue, { desc = "Continue", buffer = 0 })
          vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Step over", buffer = 0 })
          vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Step into", buffer = 0 })
          vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Step out", buffer = 0 })
          vim.keymap.set("n", "<Leader>b", dap.toggle_breakpoint, { desc = "Toggle breakpoint", buffer = 0 })
          vim.keymap.set("n", "<Leader>B", function()
            dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
          end, { desc = "Set conditional breakpoint", buffer = 0 })
          vim.keymap.set("n", "<Leader>dr", dap.repl.open, { desc = "Open a REPL", buffer = 0 })
          vim.keymap.set("n", "<Leader>dl", dap.run_last, { desc = "Run last", buffer = 0 })
        end,
      })
    end,
  },
}
