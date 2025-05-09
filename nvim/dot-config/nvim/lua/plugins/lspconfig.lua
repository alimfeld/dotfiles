return {
  -- https://github.com/neovim/nvim-lspconfig
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lspconfig = require("lspconfig")

    local server_configs = {
      denols = {
        root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
      },
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
      ts_ls = {
        root_dir = lspconfig.util.root_pattern("package.json"),
        single_file_support = false,
      },
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

    for server, config in pairs(server_configs) do
      lspconfig[server].setup(config)
    end
  end,
}
