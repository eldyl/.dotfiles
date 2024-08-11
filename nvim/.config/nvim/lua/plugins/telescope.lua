return {
  -- https://github.com/nvim-telescope/telescope.nvim
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = "Telescope",
  lazy = true,
  keys = {
    {
      "<leader>tt",
      "<cmd>Telescope find_files theme=dropdown<cr>",
      desc = "Find Files",
    },
    {
      "<leader>tl",
      "<cmd>Telescope live_grep<cr>",
      desc = "Live Grep",
    },
    {
      "<leader>ts",
      "<cmd>Telescope grep_string<cr>",
      desc = "Grep String",
    },
    {
      "<leader>tg",
      "<cmd>Telescope git_files<cr>",
      desc = "Git Files",
    },
    {
      "<leader>tb",
      "<cmd>Telescope buffers theme=dropdown<cr>",
      desc = "Buffers",
    },
    {
      "<leader>th",
      "<cmd>Telescope help_tags<cr>",
      desc = "Helper Tags",
    },
    {
      "<leader>tq",
      "<cmd>Telescope quickfix<cr>",
      desc = "Quick Fix list",
    },
  },
}
