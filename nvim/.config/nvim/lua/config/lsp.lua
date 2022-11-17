local M = {}

local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = "LSP: " .. desc
    end

    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  end

  nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
  nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

  nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
  nmap("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
  nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
  nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
  nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

  nmap("K", vim.lsp.buf.hover, "Hover Documentation")
  nmap("<leader>k", vim.lsp.buf.signature_help, "Signature Documentation")

  -- Lesser used LSP functionality
  nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
  nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
  nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
  nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
  nmap("<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, "[W]orkspace [L]ist Folders")
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
            telemetry = { enable = false },
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
