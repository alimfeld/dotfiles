local M = {}

function M.setup()
  require("gruvbox").setup()
  vim.cmd([[colorscheme gruvbox]])
end

return M
