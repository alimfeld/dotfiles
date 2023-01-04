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

    use { "tpope/vim-fugitive" }
    use { "tpope/vim-sleuth" }
    use { "tpope/vim-surround" }
    use { "christoomey/vim-tmux-navigator" }
    use { "ellisonleao/gruvbox.nvim" }
    use { "folke/which-key.nvim" }
    use { "lewis6991/gitsigns.nvim" }
    use { "numToStr/Comment.nvim" }
    use { "nvim-lua/plenary.nvim" }
    use { "nvim-lualine/lualine.nvim" }
    use { "nvim-telescope/telescope.nvim", branch = "0.1.x" }
    use { "nvim-treesitter/nvim-treesitter" }
    use { "nvim-treesitter/nvim-treesitter-textobjects" }

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
    use { "mfussenegger/nvim-jdtls" }
    use { "mfussenegger/nvim-dap" }
    use { "jayp0521/mason-null-ls.nvim" }
    use { "jayp0521/mason-nvim-dap.nvim" }
    use { "jose-elias-alvarez/null-ls.nvim" }

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
