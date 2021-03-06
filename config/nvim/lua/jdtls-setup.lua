local M = {}

function M.setup()
	local on_attach = function(client, bufnr)
		require('jdtls.setup').add_commands()
		require('jdtls').setup_dap()

		local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
		local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

		buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

		-- General keybinds
		local opts = { noremap=true, silent=true }
		buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
		buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
		buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
		buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
		buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
		buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
		buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
		buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
		buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
		buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
		buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
		buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
		buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
		buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
		buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

		-- Set some keybinds conditional on server capabilities
		if client.resolved_capabilities.document_formatting then
			buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
		elseif client.resolved_capabilities.document_range_formatting then
			buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
		end

		-- Java specific
		buf_set_keymap("n", "<A-CR>", "<Cmd>lua require'jdtls'.code_action()<CR>", opts)
		buf_set_keymap("v", "<A-CR>", "<Esc><Cmd>lua require'jdtls'.code_action(true)<CR>", opts)
		buf_set_keymap("n", "<leader>r", "<Cmd>lua require'jdtls'.code_action(false, 'refactor')<CR>", opts)

		buf_set_keymap("n", "crv", "<Cmd>lua require('jdtls').extract_variable()<CR>", opts)
		buf_set_keymap("v", "crv", "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", opts)
		buf_set_keymap("v", "crm", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", opts)
		buf_set_keymap("n", "<leader>df", "<Cmd>lua require'jdtls'.test_class()<CR>", opts)
		buf_set_keymap("n", "<leader>dn", "<Cmd>lua require'jdtls'.test_nearest_method()<CR>", opts)
	end

	local root_markers = {'.git', 'mvnw', 'gradlew'}
	local root_dir = require('jdtls.setup').find_root(root_markers)
	local home = os.getenv('HOME')
	local workspace_folder = home .. "/.jdtls/workspace/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

	local config = {}
	config.cmd = {'jdtls', workspace_folder}
	config.on_attach = on_attach
	config.root_dir = root_dir

    -- settings
    config.settings = {
        java = {
            signatureHelp = { enabled = true },
            sources = {
                organizeImports = {
                    starThreshold = 9999,
                    staticStarThreshold = 9999
                }
            },
            format = {
                settings = {
                    url = home .. "/.jdtls/eclipse-java-google-style.xml",
                    profile = "GoogleStyle"
                }
            },
            configuration = {
                runtimes = {
                    {
                        name = "JavaSE-1.8",
                        path = home .. "/.sdkman/candidates/java/8.0.282-open/"
                    },
                    {
                        name = "JavaSE-11",
                        path = home .. "/.sdkman/candidates/java/11.0.10-open/"
                    }
                }
            }
        }
    }

    -- init_options
    local bundles = {
        vim.fn.glob(home .. "/.jdtls/java-debug.jar")
    }
    vim.list_extend(bundles, vim.split(vim.fn.glob(home .. "/.jdtls/vscode-java-test/*.jar"), "\n"))
    config.init_options = {
        bundles = bundles
    }

	-- Server
	require('jdtls').start_or_attach(config)
end

return M
