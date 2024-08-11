-- Add column when in insert mode
local win_enter_group =
  vim.api.nvim_create_augroup("EnterForColumn", { clear = true })
vim.api.nvim_create_autocmd("InsertEnter", {
  group = win_enter_group,
  callback = function()
    vim.schedule(function()
      vim.opt.colorcolumn = "80"
    end)
  end,
})
-- Remove column when leaving insert mode
local win_leave_group =
  vim.api.nvim_create_augroup("LeaveNoMoColumn", { clear = true })
vim.api.nvim_create_autocmd("InsertLeave", {
  group = win_leave_group,
  callback = function()
    vim.schedule(function()
      vim.opt.colorcolumn = "0"
    end)
  end,
})

-- Clear last search when leaving a buffer | Life changing...
local clear_search_group =
  vim.api.nvim_create_augroup("ClearLastSearchOnBufLeave", { clear = true })
vim.api.nvim_create_autocmd("BufLeave", {
  group = clear_search_group,
  callback = function()
    vim.schedule(function()
      vim.cmd("noh")
    end)
  end,
})
