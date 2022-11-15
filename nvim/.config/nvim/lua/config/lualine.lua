local M = {}

function M.setup()
  require("lualine").setup({
    options = {
      theme = "gruvbox",
      globalstatus = true,
    },
  })
end

return M
