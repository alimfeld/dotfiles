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

    use { "wbthomason/packer.nvim" }

    -- Utils
    use { "nvim-lua/plenary.nvim" }

    -- Colorscheme
    use { "ellisonleao/gruvbox.nvim" }

    -- Icons
    use { "kyazdani42/nvim-web-devicons" }

    -- Statusline
    use { "nvim-lualine/lualine.nvim" }

    -- Bufferline
    use { "akinsho/bufferline.nvim" }

    -- Indent guides
    use { "lukas-reineke/indent-blankline.nvim" }

    -- Tree
    use { "kyazdani42/nvim-tree.lua"}

    -- Telescope
    use { "nvim-telescope/telescope.nvim", branch = "0.1.x" }

    -- Term
    use { "akinsho/toggleterm.nvim" }

    -- Git
    use { "tpope/vim-fugitive" }
    use { "lewis6991/gitsigns.nvim" }

    -- Comment
    use { "numToStr/Comment.nvim" }

    -- Utils
    use { "wellle/targets.vim" }
    use { "tpope/vim-sleuth" }
    use { "tpope/vim-surround" }
    use { "tpope/vim-repeat" }

    -- Editorconfig
    use { "editorconfig/editorconfig-vim" }

    -- Tmux integration
    use { "christoomey/vim-tmux-navigator" }

    -- Keymappings
    use { "folke/which-key.nvim" }

    -- Treesitter
    use { "nvim-treesitter/nvim-treesitter" }
    use { "nvim-treesitter/nvim-treesitter-textobjects" }

    -- LSP & Snippets
    use {
      'VonHeikemen/lsp-zero.nvim',
      requires = {
        -- LSP Support
        { 'neovim/nvim-lspconfig' },
        { 'williamboman/mason.nvim' },
        { 'williamboman/mason-lspconfig.nvim' },
        -- Autocompletion
        { 'hrsh7th/nvim-cmp' },
        { 'hrsh7th/cmp-buffer' },
        { 'hrsh7th/cmp-path' },
        { 'saadparwaiz1/cmp_luasnip' },
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'hrsh7th/cmp-nvim-lua' },
        -- Snippets
        { 'L3MON4D3/LuaSnip' },
        { 'rafamadriz/friendly-snippets' },
      }
    }

    -- Java
    use { "mfussenegger/nvim-jdtls" }

    -- DAP
    use { "mfussenegger/nvim-dap" }
    use { "jayp0521/mason-nvim-dap.nvim" }

    -- Null-ls
    use { "jose-elias-alvarez/null-ls.nvim" }
    use { "jayp0521/mason-null-ls.nvim" }

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
