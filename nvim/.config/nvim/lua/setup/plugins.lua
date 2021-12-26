-- Bootstrap packer
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local packer_bootstrap = nil

if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	vim.cmd([[packadd packer.nvim]])
end

-- Sync upon save
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

return require("packer").startup(function(use)
	-- packer itself
	use("wbthomason/packer.nvim")

	-- treesitter
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })

	-- lsp
	use({
		"williamboman/nvim-lsp-installer",
		requires = {
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
			"folke/which-key.nvim",
		},
		config = function()
			require("config.lsp")
		end,
	})

	-- telescope
	use({
		"nvim-telescope/telescope.nvim",
		requires = { "nvim-lua/plenary.nvim", "folke/which-key.nvim" },
		config = function()
			require("config.telescope")
		end,
	})

	-- cmp
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/vim-vsnip",
			"onsails/lspkind-nvim",
		},
		config = function()
			require("config.cmp")
		end,
	})

	-- Comment
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("config.Comment")
		end,
	})

	-- vim-fugitive
	use("tpope/vim-fugitive")

	-- gitsigns
	use({
		"lewis6991/gitsigns.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("config.gitsigns")
		end,
	})

	-- vim-tmux-navigator
	use("christoomey/vim-tmux-navigator")

	-- nvim-tree
	use({
		"kyazdani42/nvim-tree.lua",
		config = function()
			require("config.nvim-tree")
		end,
	})

	-- neoformat
	use({
		"sbdchd/neoformat",
		config = function()
			require("config.neoformat")
		end,
	})

	-- colorscheme
	use({
		"sainnhe/gruvbox-material",
		config = function()
			require("config.gruvbox-material")
		end,
	})

	-- lualine
	use({
		"nvim-lualine/lualine.nvim",
		config = function()
			require("config.lualine")
		end,
	})

	-- web-devicons
	use("kyazdani42/nvim-web-devicons")

	-- Sync upon bootstrap
	if packer_bootstrap then
		require("packer").sync()
	end
end)
