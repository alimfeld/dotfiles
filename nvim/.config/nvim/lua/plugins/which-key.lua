return {
  "folke/which-key.nvim",
  opts = {
    plugins = { spelling = true },
    defaults = {
      mode = { "n", "v" },
      ["["] = { name = "+prev" },
      ["]"] = { name = "+next" },
      ["g"] = { name = "+goto" },
      ["s"] = { name = "+Surrounding" },
      ["<leader>g"] = { name = "+Git", _ = "which_key_ignore" },
      ["<leader>t"] = { name = "+Toggle", _ = "which_key_ignore" },
      ["<leader>w"] = { name = "+Wiki", _ = "which_key_ignore" },
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    wk.register(opts.defaults)
  end,
}
