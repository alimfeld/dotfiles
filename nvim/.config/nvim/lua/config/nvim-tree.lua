local M = {}

function M.setup()
  require("nvim-tree").setup()
  vim.keymap.set("n", "<leader>tt", "<Cmd>NvimTreeToggle<CR>", { desc = "[T]oggle [T]ree"})
end

return M
