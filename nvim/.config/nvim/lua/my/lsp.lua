local M = {}

local capabilities = require("cmp_nvim_lsp").default_capabilities()

function M.setup()
  require("mason").setup()
  -- null-ls
  require("mason-null-ls").setup({
    automatic_setup = true,
  })
  require("mason-null-ls").setup_handlers({})
  require("null-ls").setup()
  -- lspconfig
  require("mason-lspconfig").setup()
  require("mason-lspconfig").setup_handlers({
    function(lsp)
      require("lspconfig")[lsp].setup({
        capabilities = capabilities,
      })
    end,
    ["jdtls"] = function()
      -- do nothing... jdtls setup is handled by nvim-jdtls
    end,
    ["sumneko_lua"] = function()
      require("lspconfig").sumneko_lua.setup({
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
  -- dap
  require("mason-nvim-dap").setup({
    automatic_setup = true,
  })
  require("mason-nvim-dap").setup_handlers({})
end

local jdtls_configured = false
local jdtls_cmd
local jdtls_bundles

function M.setup_java()
  if not jdtls_configured then
    -- we rely on jdtls being installed w/ Mason
    local mason_packages = os.getenv("HOME") .. "/.local/share/nvim/mason/packages"
    local jdtls_package = mason_packages .. "/jdtls"
    if vim.fn.isdirectory(jdtls_package) then
      -- conveniently Mason also downloads lombok
      local lombok = jdtls_package .. "/lombok.jar"
      jdtls_cmd = {
        jdtls_package .. "/bin/jdtls",
        "--jvm-arg=-javaagent:" .. lombok,
      }
      -- add bundles installed w/ Mason
      jdtls_bundles = {}
      vim.fn.glob(mason_packages .. "/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar", 1, 1)
      vim.list_extend(jdtls_bundles, vim.fn.glob(mason_packages .. "/java-test/extension/server/*[0123456789].jar", 1, 1))
    end
    -- do this configuration just once
    jdtls_configured = true
  end

  if jdtls_cmd then
    local jdtls = require("jdtls")
    local config = {
      cmd = jdtls_cmd,
      root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", ".gradlew" }),
      init_options = {
        bundles = jdtls_bundles,
      },
      on_attach = function(_, _)
        jdtls.setup_dap({ hotcodereplace = "auto" })
        jdtls.setup.add_commands()
      end,
      capabilities = capabilities,
    }
    jdtls.start_or_attach(config)
  end
end

return M
