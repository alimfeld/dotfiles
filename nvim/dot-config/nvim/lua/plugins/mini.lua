return {
  -- https://github.com/echasnovski/mini.nvim
  "echasnovski/mini.nvim",
  event = "VeryLazy",
  config = function()
    require("mini.ai").setup() -- extend and create a/i textobjects
    require("mini.bracketed").setup() -- go forward/backward with brackets (i.e. ] and [)
    require("mini.icons").setup() -- icon provider
    require("mini.surround").setup() -- add/delete/replace/... surroundings (sa, sd, sr)
  end,
}
