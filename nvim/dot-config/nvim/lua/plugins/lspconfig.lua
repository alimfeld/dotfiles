return {
  -- https://github.com/neovim/nvim-lspconfig
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    vim.lsp.config("lua_ls", {
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
    })
    vim.lsp.config("yamlls", {
      settings = {
        yaml = {
          schemas = {
            ["https://taskfile.dev/schema.json"] = { "**/Taskfile.yml", "**/*Tasks.yml" },
          },
        },
      },
    })

    vim.lsp.enable("helm_ls")
    vim.lsp.enable("jdtls")
    vim.lsp.enable("marksman")
    -- vim.lsp.enable("pylsp")
    vim.lsp.enable("pyright")
    vim.lsp.enable("terraformls")
    vim.lsp.enable("ts_ls")
    vim.lsp.enable("yamlls")
  end,
}
