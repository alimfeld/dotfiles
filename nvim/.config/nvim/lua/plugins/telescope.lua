return {
  "telescope.nvim",
  dependencies = {
    "nvim-telescope/telescope-live-grep-args.nvim",
    config = function()
      require("telescope").load_extension("live_grep_args")
    end,
    keys = {
      {
        "<leader>sl",
        function()
          require("telescope").extensions.live_grep_args.live_grep_args()
        end,
        desc = "Live Grep",
      },
    },
  },
}
