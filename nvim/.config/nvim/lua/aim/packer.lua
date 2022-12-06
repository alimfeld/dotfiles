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

    use { "L3MON4D3/LuaSnip" }
    use { "christoomey/vim-tmux-navigator" }
    use { "ellisonleao/gruvbox.nvim" }
    use { "folke/which-key.nvim" }
    use { "hrsh7th/cmp-nvim-lsp" }
    use { "hrsh7th/nvim-cmp" }
    use { "jayp0521/mason-null-ls.nvim" }
    use { "jayp0521/mason-nvim-dap.nvim" }
    use { "jose-elias-alvarez/null-ls.nvim" }
    use { "lewis6991/gitsigns.nvim" }
    use { "mfussenegger/nvim-dap" }
    use { "mfussenegger/nvim-jdtls" }
    use { "neovim/nvim-lspconfig" }
    use { "numToStr/Comment.nvim" }
    use { "nvim-lua/plenary.nvim" }
    use { "nvim-lualine/lualine.nvim" }
    use { "nvim-telescope/telescope.nvim", branch = "0.1.x" }
    use { "nvim-treesitter/nvim-treesitter" }
    use { "nvim-treesitter/nvim-treesitter-textobjects" }
    use { "saadparwaiz1/cmp_luasnip" }
    use { "tpope/vim-fugitive" }
    use { "tpope/vim-sleuth" }
    use { "tpope/vim-surround" }
    use { "wbthomason/packer.nvim" }
    use { "williamboman/mason-lspconfig.nvim" }
    use { "williamboman/mason.nvim" }

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
