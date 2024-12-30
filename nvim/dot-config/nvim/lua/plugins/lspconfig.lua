return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "cenk1cenk2/schema-companion.nvim",
  },
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("schema-companion").setup({
      log_level = vim.log.levels.INFO,
      enable_telescope = true,
      matchers = {
        require("schema-companion.matchers.kubernetes").setup({ version = "master" }),
      },
      schemas = {},
    })

    local server_configs = {
      gopls = {},
      helm_ls = require("schema-companion").setup_client({}),
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
            completion = {
              callSnippet = "Replace",
            },
          },
        },
      },
      marksman = {},
      pyright = {},
      terraformls = {},
      yamlls = require("schema-companion").setup_client({
        settings = {
          redhat = {
            telemetry = {
              enabled = false,
            },
          },
          yaml = {},
        },
      }),
    }

    local lspconfig = require("lspconfig")
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

    for server, config in pairs(server_configs) do
      config.capabilities = vim.tbl_deep_extend("force", {}, capabilities, config.capabilities or {})
      lspconfig[server].setup(config)
    end

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = event.buf, desc = desc })
        end
        map("gd", require("telescope.builtin").lsp_definitions, "Definition")
        map("gr", require("telescope.builtin").lsp_references, "References")
        map("<leader>r", vim.lsp.buf.rename, "Rename")
        map("<leader>a", vim.lsp.buf.code_action, "Code action")
        map("<leader>y", require("telescope").extensions.schema_companion.select_from_matching_schemas, "YAML Schema")
      end,
    })
  end,
}
