return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
  },
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local server_configs = {
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
            telemetry = {
              enable = false,
            },
          },
        },
      },
      terraformls = {},
      gopls = {},
      marksman = {},
    }

    local lspconfig = require("lspconfig")
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

    for server, config in pairs(server_configs) do
      config.capabilities = vim.tbl_deep_extend("force", {}, capabilities, config.capabilities or {})
      lspconfig[server].setup(config)
    end

    -- Use LspAttach autocommand to only map the following keys
    -- after the language server attaches to the current buffer
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = event.buf, desc = desc })
        end

        -- Jump to the definition of the word under your cursor.
        --  This is where a variable was first declared, or where a function is defined, etc.
        --  To jump back, press <C-T>.
        map("gd", require("telescope.builtin").lsp_definitions, "Definition")

        -- Find references for the word under your cursor.
        map("gr", require("telescope.builtin").lsp_references, "References")

        -- Jump to the implementation of the word under your cursor.
        --  Useful when your language has ways of declaring types without an actual implementation.
        map("gI", require("telescope.builtin").lsp_implementations, "Implementation")

        -- Jump to the type of the word under your cursor.
        --  Useful when you're not sure what type a variable is and you want to see
        --  the definition of its *type*, not where it was *defined*.
        map("gy", require("telescope.builtin").lsp_type_definitions, "Type definition")

        -- Rename the variable under your cursor
        --  Most Language Servers support renaming across files, etc.
        map("<leader>r", vim.lsp.buf.rename, "Rename")

        -- Execute a code action, usually your cursor needs to be on top of an error
        -- or a suggestion from your LSP for this to activate.
        map("<leader>a", vim.lsp.buf.code_action, "Code action")

        -- Opens a popup that displays documentation about the word under your cursor
        --  See `:help K` for why this keymap
        map("K", vim.lsp.buf.hover, "Hover documentation")

        -- WARN: This is not Goto Definition, this is Goto Declaration.
        --  For example, in C this would take you to the header
        map("gD", vim.lsp.buf.declaration, "Declaration")
      end,
    })
  end,
}
