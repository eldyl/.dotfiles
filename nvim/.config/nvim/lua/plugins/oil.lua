return {
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    config = function()
      require("oil").setup({
        columns = { "icon" },
        watch_for_changes = true,
        view_options = {
          show_hidden = true,
          is_always_hidden = function(name, bufnr)
            if name == ".DS_Store" then
              return true
            end
          end,
        },
      })

      -- Open parent directory in current window
      vim.keymap.set(
        "n",
        "-",
        "<CMD>Oil<CR>",
        { desc = "Open parent directory" }
      )

      -- Open parent directory in floating window
      vim.keymap.set("n", "<space>-", require("oil").toggle_float)
    end,
  },
}
