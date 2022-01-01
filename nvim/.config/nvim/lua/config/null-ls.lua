local null_ls = require("null-ls")

local builtins = null_ls.builtins

null_ls.setup({
	sources = {
		builtins.formatting.stylua,
		builtins.formatting.prettier,
	},
	on_attach = function(client)
		if client.resolved_capabilities.document_formatting then
			vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
		end
	end,
})
