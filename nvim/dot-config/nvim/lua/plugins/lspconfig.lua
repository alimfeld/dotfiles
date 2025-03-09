return {
  -- https://github.com/neovim/nvim-lspconfig
  -- TODO: Refactor once neovim 0.11 is released (see https://github.com/neovim/nvim-lspconfig/issues/3494)
  "neovim/nvim-lspconfig",
  dependencies = { "saghen/blink.cmp" },
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local server_configs = {
      gopls = {},
      helm_ls = {},
      jdtls = {},
      lua_ls = {
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            workspace = {
              checkThirdParty = false,
              library = {
                "${3rd}/luv/library",
                unpack(vim.api.nvim_get_runtime_file("", true)),
              },
            },
          },
        },
      },
      marksman = {},
      pyright = {},
      terraformls = {},
      yamlls = {
        settings = {
          yaml = {
            schemas = {
              ["https://taskfile.dev/schema.json"] = { "**/Taskfile.yml", "**/*Tasks.yml" },
            },
          },
        },
      },
    }

    local lspconfig = require("lspconfig")
    for server, config in pairs(server_configs) do
      config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
      lspconfig[server].setup(config)
    end
  end,
}
