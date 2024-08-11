return {
  {
    --https://github.com/shortcuts/no-neck-pain.nvim
    "shortcuts/no-neck-pain.nvim",
    version = "*",
    keys = {
      { "<C-z>", "<cmd>NoNeckPain<cr>", desc = "No Neck Pain" },
    },
    opts = {
      width = 100,
      buffers = {
        scratchPad = {
          -- set to `false` to
          -- disable auto-saving
          enabled = true,
          -- set to `nil` to default
          -- to current working directory
          location = "~/Documents/nvim_scratch",
        },
        bo = {
          filetype = "md",
        },
        right = {
          enabled = false,
        },
        blend = -0.2,
        wo = {
          fillchars = "eob: ",
        },
      },
    },
  },
}
