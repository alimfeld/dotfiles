local lsp_installer = require("nvim-lsp-installer")

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

local wk = require("which-key")

local on_attach = function(_, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end
	local opts = { noremap = true, silent = true }
	buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)

	buf_set_keymap("n", "<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
	buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
	buf_set_keymap("n", "<space>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)

	wk.register({
		["g"] = {
			name = "goto",
			d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Definition" },
			D = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Declaration" },
			i = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "Implementation" },
			t = { "<cmd>lua vim.lsp.buf.type_definition()<cr>", "Type Definition" },
			r = { "<cmd>lua vim.lsp.buf.references()<cr>", "References" },
		},
	}, {
		buffer = bufnr,
	})

	wk.register({
		["<leader>l"] = {
			name = "lsp",
			r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
			c = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
			f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format" },
		},
	}, {
		buffer = bufnr,
	})
end

lsp_installer.on_server_ready(function(server)
	local opts = {
		on_attach = on_attach,
		capabilities = capabilities,
	}

	if server.name == "sumneko_lua" then
		opts.settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
			},
		}
	end

	if server.name == "jsonls" then
		opts.settings = {
			json = {
				schemas = {
					{
						description = "NPM package.json files",
						fileMatch = {
							"package.json",
						},
						url = "https://json.schemastore.org/package.json",
					},
				},
			},
		}
	end

	server:setup(opts)
end)
