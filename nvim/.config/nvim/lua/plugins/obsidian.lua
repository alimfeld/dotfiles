return {
  "epwalsh/obsidian.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
    "nvim-telescope/telescope.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  keys = {
    { "<leader>od", "<cmd>ObsidianDailies<cr>", desc = "Obsidian Dailies" },
    { "<leader>on", "<cmd>ObsidianNew<cr>", desc = "Obsidian New" },
    { "<leader>os", "<cmd>ObsidianSearch<cr>", desc = "Obsidian Search" },
    { "<leader>ot", "<cmd>ObsidianToday<cr>", desc = "Obsidian Today" },
    { "<leader>oy", "<cmd>ObsidianYesterday<cr>", desc = "Obsidian Yesterday" },
    { "<leader>of", "<cmd>ObsidianQuickSwitch<cr>", desc = "Obsidian Find (Quick Switch)" },
  },
  opts = {
    workspaces = {
      {
        name = "Notes",
        path = "~/vaults/Notes",
      },
    },
    daily_notes = {
      folder = "daily",
    },
    note_id_func = function(title)
      local suffix = ""
      if title ~= nil then
        suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
      else
        -- If title is nil, just add 4 random uppercase letters to the suffix.
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
        end
      end
      return os.date("%Y%m%d%H%M") .. "-" .. suffix
    end,
  },
}
