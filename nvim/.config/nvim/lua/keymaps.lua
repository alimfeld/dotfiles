vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

local telescope_builtin = require("telescope.builtin")

local function map(lhs, rhs, desc)
  vim.keymap.set("n", lhs, rhs, { desc = desc })
end

if 1 then
  ---@format disable
  map("<leader>f",       telescope_builtin.find_files,          "List [f]iles")
  map("<leader>b",       telescope_builtin.buffers,             "List open [b]uffers")
  map("<leader>/",       telescope_builtin.live_grep,           "Grep files")
  map("<leader>t",       "<Cmd>NvimTreeToggle<CR>",             "Toggle [t]ree")

  map("[d",              vim.diagnostic.goto_prev,              "Previous [d]iagnostic")
  map("]d",              vim.diagnostic.goto_next,              "Next [d]iagnostic")
end

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local function buf_map(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, { desc = desc, buffer = args.buf })
    end

    if 1 then
      ---@format disable
      buf_map("<leader>=",       vim.lsp.buf.format,                    "LSP format")
      buf_map("<leader>r",       vim.lsp.buf.rename,                    "LSP [r]ename")
      buf_map("<leader>c",       vim.lsp.buf.code_action,               "LSP [c]ode action")

      buf_map("<leader>e",       telescope_builtin.diagnostics,         "LSP diagnostics")
      buf_map("gd",              telescope_builtin.lsp_definitions,     "LSP [d]efinitions")
      buf_map("gr",              telescope_builtin.lsp_references,      "LSP [r]eferences")

      buf_map("K",               vim.lsp.buf.hover,                     "LSP hover")
    end


    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if (client.name == 'jdtls') then
      local jdtls = require("jdtls")
      ---@format disable
      buf_map("<leader>df",      jdtls.test_class,                      "Test class")
      buf_map("<leader>dn",      jdtls.test_nearest_method,             "Test nearest method")
    end
  end,
})
