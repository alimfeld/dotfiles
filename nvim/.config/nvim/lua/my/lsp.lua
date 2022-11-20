local M = {}

local on_attach = function(_, _)
  -- Currently all LSP related keymaps are applied globally
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

function M.setup()
  require("mason").setup()
  require("mason-null-ls").setup({
    automatic_setup = true,
  })
  require("mason-null-ls").setup_handlers({})
  require("null-ls").setup()
  require("mason-lspconfig").setup()
  require("mason-lspconfig").setup_handlers({
    function(lsp)
      require("lspconfig")[lsp].setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })
    end,
    ["jdtls"] = function()
      -- do nothing... jdtls setup is handled by nvim-jdtls
    end,
    ["sumneko_lua"] = function()
      require("lspconfig").sumneko_lua.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      })
    end,
  })
end

local jdtls_configured = false
local jdtls_cmd

function M.setup_java()
  if not jdtls_configured then
    -- we rely on jdtls being installed via Mason
    local home = os.getenv("HOME")
    local base = home .. "/.local/share/nvim/mason/packages/jdtls"
    if vim.fn.isdirectory(base) then
      -- conveniently Mason also downloads lombok
      local lombok = base .. "/lombok.jar"
      jdtls_cmd = {
        base .. "/bin/jdtls",
        "--jvm-arg=-javaagent:" .. lombok,
      }
    end
    -- do this configuration just once
    jdtls_configured = true
  end

  if jdtls_cmd then
    local config = {
      cmd = jdtls_cmd,
      on_attach = on_attach,
      capabilities = capabilities,
      root_dir = vim.fs.dirname(vim.fs.find({ ".gradlew", ".git", "mvnw" }, { upward = true })[1]),
    }
    require("jdtls").start_or_attach(config)
  end
end

return M
