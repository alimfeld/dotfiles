return {
	{
		"ThePrimeagen/harpoon",
		keys = {
			{
				"<leader>hh",
				function()
					require("harpoon.ui").toggle_quick_menu()
				end,
				desc = "Toggle quick menu",
			},
			{
				"<leader>ha",
				function()
					require("harpoon.mark").add_file()
				end,
				desc = "Add file",
			},
		},
	},
}
