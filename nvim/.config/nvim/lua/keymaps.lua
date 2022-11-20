vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

local function nmap(lhs, rhs, desc)
  vim.keymap.set("n", lhs, rhs, { desc = desc })
end

local telescope_builtin = require("telescope.builtin")

---@format disable
nmap("<leader>f",       telescope_builtin.find_files,          "List [f]iles")
nmap("<leader>b",       telescope_builtin.buffers,             "List open [b]uffers")
nmap("<leader>/",       telescope_builtin.live_grep,           "Grep files")
nmap("<leader>t",       "<Cmd>NvimTreeToggle<CR>",             "Toggle [t]ree")

nmap("[d",              vim.diagnostic.goto_prev,              "Previous [d]iagnostic")
nmap("]d",              vim.diagnostic.goto_next,              "Next [d]iagnostic")

nmap("<leader>=",       vim.lsp.buf.format,                    "Format")
nmap("<leader>r",       vim.lsp.buf.rename,                    "LSP: [r]ename")
nmap("<leader>c",       vim.lsp.buf.code_action,               "LSP: [c]ode action")

nmap("<leader>d",       telescope_builtin.diagnostics,         "LSP: List [d]iagnostics")
nmap("gd",              telescope_builtin.lsp_definitions,     "LSP: Goto [d]efinition")
nmap("gr",              telescope_builtin.lsp_references,      "LSP: Goto [r]eferences")

nmap("K",               vim.lsp.buf.hover,                     "Hover Documentation")
