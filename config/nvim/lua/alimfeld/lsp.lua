local lsp = {}

function lsp.setup()

    local on_attach = function(_, bufnr)
        require'alimfeld.mappings'.setup_lsp(bufnr)
    end

    local capabilities = require'cmp_nvim_lsp'.update_capabilities(
    vim.lsp.protocol.make_client_capabilities())

    local nvim_lsp = require'lspconfig'

    nvim_lsp.sumneko_lua.setup {
        settings = {
            Lua = {
                diagnostics = {
                    globals = {"vim"},
                },
            },
        },
        on_attach = on_attach,
        flags = {
            debounce_text_changes = 150,
        },
        capabilities = capabilities,
    }

end

return lsp;
