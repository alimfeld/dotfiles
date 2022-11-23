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
    use("wbthomason/packer.nvim")

    use("tpope/vim-fugitive")
    use("tpope/vim-sleuth")
    use("tpope/vim-surround")
    use("christoomey/vim-tmux-navigator")

    -- Display keybindings
    use({
      "folke/which-key.nvim",
      config = function()
        require("which-key").setup()
      end,
    })
    -- Git integration for buffers
    use({
      "lewis6991/gitsigns.nvim",
      config = function()
        require("gitsigns").setup()
      end,
    })
    -- Comment (gc)
    use({
      "numToStr/Comment.nvim",
      config = function()
        require("Comment").setup()
      end,
    })
    -- Colorscheme
    use({
      "ellisonleao/gruvbox.nvim",
      config = function()
        require("gruvbox").setup()
        vim.cmd([[colorscheme gruvbox]])
      end,
    })
    -- Statusline
    use({
      "nvim-lualine/lualine.nvim",
      config = function()
        require("lualine").setup({
          options = {
            theme = "gruvbox",
            globalstatus = true,
          },
        })
      end,
    })
    -- Tree
    use({
      "nvim-tree/nvim-tree.lua",
      requires = { "nvim-tree/nvim-web-devicons" },
      config = function()
        require("nvim-tree").setup()
      end
    })

    -- Treesitter
    use("nvim-treesitter/nvim-treesitter")
    use({ "nvim-treesitter/nvim-treesitter-textobjects", after = "nvim-treesitter" })
    -- Telescope
    use({ "nvim-telescope/telescope.nvim", branch = "0.1.x", requires = { "nvim-lua/plenary.nvim" } })
    -- Snippets
    use("L3MON4D3/LuaSnip")
    -- Completion
    use({ "hrsh7th/nvim-cmp", requires = { "hrsh7th/cmp-nvim-lsp", "saadparwaiz1/cmp_luasnip" } })
    -- LSP & Co
    use("neovim/nvim-lspconfig")
    use("williamboman/mason.nvim")
    use("williamboman/mason-lspconfig.nvim")
    use("jose-elias-alvarez/null-ls.nvim")
    use("mfussenegger/nvim-jdtls")
    use("mfussenegger/nvim-dap")
    use("jayp0521/mason-null-ls.nvim")
    use("jayp0521/mason-nvim-dap.nvim")

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

require("my.treesitter").setup()
require("my.cmp").setup()
require("my.lsp").setup()
