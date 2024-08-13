return {
  {
    -- https://github.com/tpope/vim-fugitive
    "tpope/vim-fugitive",
    cmd = { "Git", "G" },
    keys = {
      -- Information
      { "<leader>gg", "<cmd>Git<cr>", desc = "Open Git Status" },
      { "<leader>gd", "<cmd>Gvdiff<cr>", desc = "Open difftool" },
      {
        "<leader>gs",
        "<cmd>Telescope git_status<cr>",
        desc = "View Git Status via Telescope",
      },
      {
        "<leader>gb",
        "<cmd>Telescope git_branches<cr>",
        desc = "View Git Branches via Telescope",
      },
      {
        "<leader>gc",
        "<cmd>Telescope git_commits<cr>",
        desc = "View Git Commits via Telescope",
      },
      {
        "<leader>gf",
        "<cmd>Telescope git_bcommits<cr>",
        desc = "View Git Commits for buffer via Telescope",
      },
      -- Actions
      { "<leader>gC", "<cmd>Git commit<cr>", desc = "Git Commit" },
      {
        "<leader>gR",
        "<cmd>Git rebase -i<cr>",
        desc = "Start interactive rebase",
      },
      { "<leader>gP", "<cmd>Git push<cr>", desc = "Git Push" },
      { "<leader>gp", "<cmd>Git pull<cr>", desc = "Git Pull" },
    },
  },

  {
    -- https://github.com/lewis6991/gitsigns.nvim
    "lewis6991/gitsigns.nvim",
    event = "BufRead",
    opts = {
      signs = {
        add = { text = "" },
        delete = { text = "" },
        changedelete = { text = "󰜥" },
      },
      watch_gitdir = {
        follow_files = true,
      },
      attach_to_untracked = true,
      current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 500,
        ignore_whitespace = false,
      },
      current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil, -- Use default
      max_file_length = 40000, -- Disable if file is longer than this (in lines)
    },
    keys = {
      -- Buffer actions
      { "<leader>gA", "<cmd>Gitsigns stage_buffer<cr>", desc = "Add Buffer" },
      { "<leader>gX", "<cmd>Gitsigns reset_buffer<cr>", desc = "Reset Buffer" },
      -- Navigate hunks
      { "<leader>gn", "<cmd>Gitsigns next_hunk<cr>", desc = "Next Hunk" },
      { "<leader>gN", "<cmd>Gitsigns prev_hunk<cr>", desc = "Prev Hunk" },
      { "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", desc = "Preview Hunk" },
      -- Add/Stage hunk
      {
        "<leader>ga",
        "<cmd>Gitsigns stage_hunk<cr>",
        mode = { "n" },
        desc = "Add Hunk",
      },
      {
        "<leader>ga",
        function()
          local gs = package.loaded.gitsigns
          gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end,
        mode = { "v" },
        desc = "Add Hunk",
      },
      -- Undo Add/Stage hunk
      {
        "<leader>gu",
        "<cmd>Gitsigns undo_stage_hunk<cr>",
        desc = "Unstage Hunk",
      },
      -- Reset hunk
      {
        "<leader>gx",
        "<cmd>Gitsigns reset_hunk<cr>",
        mode = { "n" },
        desc = "Reset Hunk",
      },
      {
        "<leader>gx",
        function()
          local gs = package.loaded.gitsigns
          gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end,
        mode = { "v" },
        desc = "Reset Hunk",
      },
    },
  },
}
