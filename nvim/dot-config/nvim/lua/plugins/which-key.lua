return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local wk = require("which-key")
    wk.setup()
    wk.register({
      mode = { "n", "v" },
      ["["] = { name = "+Prev" },
      ["]"] = { name = "+Next" },
      ["g"] = { name = "+Goto" },
      ["s"] = { name = "+Surround", _ = "which_key_ignore" },
      ["<leader>d"] = { name = "+Diff", _ = "which_key_ignore" },
      ["<leader>f"] = { name = "+Find", _ = "which_key_ignore" },
      ["<leader>g"] = { name = "+Git", _ = "which_key_ignore" },
      ["<leader>t"] = { name = "+Toggle", _ = "which_key_ignore" },
    })
  end,
}
