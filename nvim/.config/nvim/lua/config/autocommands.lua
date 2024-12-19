-- Add column when in insert mode
vim.api.nvim_create_autocmd("InsertEnter", {
  desc = "Creates column at 80 char width when in insert mode",
  group = vim.api.nvim_create_augroup("insert-mode-column", { clear = true }),
  callback = function()
    vim.schedule(function()
      vim.opt.colorcolumn = "80"
    end)
  end,
})

-- Remove column when leaving insert mode
vim.api.nvim_create_autocmd("InsertLeave", {
  desc = "Removes column at 80 char width when leaving insert mode",
  group = vim.api.nvim_create_augroup(
    "leave-insert-no-column",
    { clear = true }
  ),
  callback = function()
    vim.schedule(function()
      vim.opt.colorcolumn = "0"
    end)
  end,
})

-- Highlight when yanking
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Clear last search when leaving a buffer
vim.api.nvim_create_autocmd("BufLeave", {
  desc = "Removes search highlighting when leaving a buffer",
  group = vim.api.nvim_create_augroup(
    "clear-last-searched-on-buf-leave",
    { clear = true }
  ),
  callback = function()
    vim.schedule(function()
      vim.cmd("noh")
    end)
  end,
})
