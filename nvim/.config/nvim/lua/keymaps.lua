vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

local function nmap(lhs, rhs, desc, buf)
  vim.keymap.set("n", lhs, rhs, { desc = desc, buffer = buf })
end

local telescope_builtin = require("telescope.builtin")

nmap("<leader>sf", telescope_builtin.find_files, "Search file")
nmap("<leader>sb", telescope_builtin.buffers, "Search buffer")
nmap("<leader>sp", telescope_builtin.live_grep, "Search pattern")

nmap("[d", vim.diagnostic.goto_prev, "Previous diagnostic")
nmap("]d", vim.diagnostic.goto_next, "Next diagnostic")

nmap("gs", ":e $HOME/scratch.md<CR>", "Goto scratch")

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local function buf_map(lhs, rhs, desc)
      nmap(lhs, rhs, desc, args.buf)
    end

    local dap = require("dap")

    buf_map("<leader>fo", vim.lsp.buf.format, "Format")
    buf_map("<leader>rn", vim.lsp.buf.rename, "Rename")
    buf_map("<leader>ca", vim.lsp.buf.code_action, "Code action")

    buf_map("<leader>sd", telescope_builtin.diagnostics, "Search diagnostics")
    buf_map("gd", telescope_builtin.lsp_definitions, "Goto definitions")
    buf_map("gr", telescope_builtin.lsp_references, "Goto references")

    buf_map("K", vim.lsp.buf.hover, "LSP hover")

    buf_map("<C-p>", dap.toggle_breakpoint, "Toggle breakpoint")

    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if (client.name == 'jdtls') then
      local jdtls = require("jdtls")
      buf_map("<leader>oi", jdtls.organize_imports, "Organize imports")
      buf_map("<leader>df", jdtls.test_class, "Test class")
      buf_map("<leader>dn", jdtls.test_nearest_method, "Test nearest method")
    end
  end,
})
