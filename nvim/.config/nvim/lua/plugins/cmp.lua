return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    -- snippet engine
    "dcampos/nvim-snippy",
    -- completion sources
    "dcampos/cmp-snippy",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
  },
  config = function()
    local snippy = require("snippy")
    snippy.setup({
      mappings = {
        is = {
          ["<Tab>"] = "expand_or_advance",
          ["<S-Tab>"] = "previous",
        },
      },
    })

    local cmp = require("cmp")
    cmp.setup({
      snippet = {
        -- REQUIRED (a snippet engine must be specified)
        expand = function(args)
          snippy.expand_snippet(args.body)
        end,
      },

      mapping = cmp.mapping.preset.insert({
        -- :help ins-completion
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete({}),
      }),
      sources = {
        { name = "nvim_lsp" },
        { name = "snippy" },
        { name = "buffer" },
        { name = "path" },
      },
    })
  end,
}
