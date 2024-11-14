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
        scratchPad = { enabled = true },
        right = {
          enabled = false,
        },
        wo = {
          fillchars = "eob: ",
        },
        bo = { filetype = "md" },
      },
    },
  },
}
