return {
	{
		"nvim-telescope/telescope.nvim",
		event = "VeryLazy",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-live-grep-args.nvim",
		},
		config = function()
			local telescope = require("telescope")
			telescope.load_extension("live_grep_args")
			local builtin = require("telescope.builtin")
			-- find (file)
			vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find Buffer" })
			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find File" })
			-- search
			vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "Search Diagnostics" })
			vim.keymap.set("n", "<leader>sg", telescope.extensions.live_grep_args.live_grep_args,
				{ desc = "Grep" })
			vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "Search Keymaps" })
		end,
	},
}
