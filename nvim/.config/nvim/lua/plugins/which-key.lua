return {
  "folke/which-key.nvim",
  opts = {
    plugins = { spelling = true },
    defaults = {
      mode = { "n", "v" },
      ["g"] = { name = "+goto" },
      ["]"] = { name = "+next" },
      ["["] = { name = "+prev" },
      ["s"] = { name = "+Surrounding" },
      ["<leader>h"] = { name = "+Hunks (Git)", _ = "which_key_ignore" },
      ["<leader>t"] = { name = "+Toggle", _ = "which_key_ignore" },
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    wk.register(opts.defaults)
  end,
}
