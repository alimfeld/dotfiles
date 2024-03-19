-- Resources:
--   A guide on Neovim's LSP client: https://vonheikemen.github.io/devlog/tools/neovim-lsp-client-guide/
--   Servier configurations: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lspconfig = require("lspconfig")

    -- lua-language-server
    lspconfig.lua_ls.setup({
      settings = {
        Lua = {
          runtime = { version = "LuaJIT" },
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME,
            },
          },
        },
      },
    })

    -- terraform-ls
    lspconfig.terraformls.setup({})

    -- Keymaps
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
      callback = function(event)
        local bufmap = function(mode, keys, func, desc)
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc })
        end
        bufmap("i", "<C-o>", "<C-x><C-o>", "Omnicomplete")
      end,
    })
  end,
}
