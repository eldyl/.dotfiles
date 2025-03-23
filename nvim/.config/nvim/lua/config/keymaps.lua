local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Paste better - Use register to keep pasted available
keymap("v", "p", '"_dP', opts)
-- Easy save
keymap('n', '<leader>w', '<cmd>w<cr>')
-- Move around split windows easier
keymap("n", "<C-Left>", "<C-W><C-h>", opts)
keymap("n", "<C-Down>", "<C-W><C-j>", opts)
keymap("n", "<C-Up>", "<C-W><C-k>", opts)
keymap("n", "<C-Right>", "<C-W><C-l>", opts)
-- Change size of split windows
keymap("n", "<C-M-Left>", "<C-W><C-<>", opts)
keymap("n", "<C-M-Down>", "<C-W><C-->", opts)
keymap("n", "<C-M-Up>", "<C-W><C-+>", opts)
keymap("n", "<C-M-Right>", "<C-W><C->>", opts)

-- Move through quickfix list
keymap("n", "<M-Down>", "<cmd>cnext<CR>", opts)
keymap("n", "<M-Up>", "<cmd>cprev<CR>", opts)

-- Show line diagnostic
keymap("n", "<leader>l", vim.diagnostic.open_float, opts)
-- Jump to next/prev diagnostic
keymap("n", "<leader>dn", vim.diagnostic.goto_next, opts)
keymap("n", "<leader>dp", vim.diagnostic.goto_prev, opts)

-- Diagnostic toggle
local diagnostics_active = true
keymap("n", "<leader>dd", function()
  diagnostics_active = not diagnostics_active
  if diagnostics_active then
    vim.diagnostic.show()
  else
    vim.diagnostic.hide()
  end
end)
