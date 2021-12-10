local mappings = {}

function mappings.setup()
    local wk = require'which-key'
    local map = vim.api.nvim_set_keymap
    wk.setup()

    -- leader
    vim.g.mapleader = ' '
    map('n', '<Space>', '<Nop>', {noremap = true})

    -- Telescope
    wk.register({
        ["<leader>f"] = {
            name = "file",
            f = { "<cmd>Telescope find_files<cr>", "Find file" },
            g = { "<cmd>Telescope git_files<cr>", "Find git file" },
            r = { "<cmd>Telescope live_grep<cr>", "Live grep" },
            b = { "<cmd>Telescope buffers<cr>", "Find buffer" },
            h = { "<cmd>Telescope help_tags<cr>", "Find help tag" },
            o = { "<cmd>Telescope help_tags<cr>", "Find recent file" },
        }
    })

    -- NvimTree
    map('n', '<C-n>', ':NvimTreeToggle<CR>', {noremap = true})

    -- Neoformat
    map('n', 'F', ':Neoformat<CR>', {noremap = true})
end


function mappings.setup_lsp(bufnr)
    local wk = require'which-key'
    wk.register({
        ["g"] = {
            name = "goto",
            d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Goto definition", buffer = bufnr},
            D = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Goto declaration", buffer = bufnr },
            i = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "Goto implementation", buffer = bufnr },
        },
        ["<leader>r"] = {
            name = "refactor",
            n = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename", buffer = bufnr },
            c = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code action", buffer = bufnr },
        },
        ["<leader>d"] = {
            name = "debug",
            c = { "<cmd>lua require'dap'.continue()<cr>", "Continue", buffer = bufnr },
            j = { "<cmd>lua require'dap'.step_over()<cr>", "Step over", buffer = bufnr },
            l = { "<cmd>lua require'dap'.step_into()<cr>", "Step into", buffer = bufnr },
            h = { "<cmd>lua require'dap'.step_out()<cr>", "Step out", buffer = bufnr },
            b = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle breakpoint", buffer = bufnr },
        }
    })
end

return mappings
