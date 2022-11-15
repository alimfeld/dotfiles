local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

require("packer").startup({
  function(use)
    -- Plugin manager for nvim (manages itself)
    use("wbthomason/packer.nvim")
    -- A Git wrapper so awesome, it should be illegal
    use("tpope/vim-fugitive")
    -- Tmux integration
    use("christoomey/vim-tmux-navigator")
    -- Use heuristics to adjust 'shiftwidth' and 'expandtab'
    use("tpope/vim-sleuth")
    -- Display keybindings
    use({ "folke/which-key.nvim", config = require("config.which-key").setup })
    -- Git integration for buffers
    use({ "lewis6991/gitsigns.nvim", config = require("config.gitsigns").setup })
    -- Smart and powerful comment plugin for neovim (gc)
    use({ "numToStr/Comment.nvim", config = require("config.comment").setup })
    -- Gruvbox colorscheme
    use({ "ellisonleao/gruvbox.nvim", config = require("config.gruvbox").setup })
    -- Neovim statusline writtern in pure lua
    use({ "nvim-lualine/lualine.nvim", config = require("config.lualine").setup })
    -- Tree
    use({
      "nvim-tree/nvim-tree.lua",
      requires = { "nvim-tree/nvim-web-devicons" },
      config = require("config.nvim-tree").setup,
    })
    -- Completion (and Snippets)
    use({
      "hrsh7th/nvim-cmp",
      requires = { "hrsh7th/cmp-nvim-lsp", "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip" },
      config = require("config.cmp").setup,
    })
    -- Telescope
    use({ "nvim-telescope/telescope.nvim", branch = "0.1.x", requires = { "nvim-lua/plenary.nvim" } })
    use({
      "nvim-telescope/telescope-fzf-native.nvim",
      requires = "nvim-telescope/telescope.nvim",
      run = "make",
      cond = vim.fn.executable("make") == 1,
    })
    -- Treesitter
    use("nvim-treesitter/nvim-treesitter")
    use({ "nvim-treesitter/nvim-treesitter-textobjects", after = "nvim-treesitter" })
    -- LSP & Co
    use("neovim/nvim-lspconfig")
    use("williamboman/mason.nvim")
    use("williamboman/mason-lspconfig.nvim")
    use("jose-elias-alvarez/null-ls.nvim")
    use("jayp0521/mason-null-ls.nvim")
    use("mfussenegger/nvim-jdtls")

    if packer_bootstrap then
      require("packer").sync()
    end
  end,
  config = {
    display = {
      open_fn = require("packer.util").float,
    },
  },
})

require("config.treesitter").setup()
require("config.telescope").setup()
require("config.lsp").setup()
