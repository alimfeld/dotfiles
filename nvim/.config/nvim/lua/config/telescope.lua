require("which-key").register({
	["<leader>f"] = {
		name = "file",
		f = { "<cmd>Telescope find_files<cr>", "Find file" },
		g = { "<cmd>Telescope git_files<cr>", "Find git file" },
		r = { "<cmd>Telescope live_grep<cr>", "Live grep" },
		b = { "<cmd>Telescope buffers<cr>", "Find buffer" },
		h = { "<cmd>Telescope help_tags<cr>", "Find help tag" },
		o = { "<cmd>Telescope help_tags<cr>", "Find recent file" },
	},
})
