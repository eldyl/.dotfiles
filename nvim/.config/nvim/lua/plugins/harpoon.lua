return {
  -- https://github.com/ThePrimeagen/harpoon
  "theprimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = "VeryLazy",
  keys = {
    {
      "<leader>h",
      function()
        local harpoon = require("harpoon")

        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
      desc = "Toggle Harpoon Menu",
    },
    {
      "<leader>m",
      function()
        local harpoon = require("harpoon")

        harpoon:list():add()
      end,
      desc = "Mark File with Harpoon",
    },
  },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup()

    -- Jump to harpooned at index w/ `CTRL+number`
    for _, idx in ipairs({ 1, 2, 3, 4, 5, 6, 7, 8, 9 }) do
      vim.keymap.set("n", string.format("<C-%d>", idx), function()
        harpoon:list():select(idx)
      end)
    end

    --https://github.com/ThePrimeagen/harpoon/issues/352#issuecomment-1893131934
    function Harpoon_files()
      local contents = {}
      local marks_length = harpoon:list():length()
      local current_file_path = vim.fn.fnamemodify(vim.fn.expand("%:p"), ":.")
      for index = 1, marks_length do
        local harpoon_file_path = harpoon:list():get(index).value
        local file_name = harpoon_file_path == "" and "(empty)"
          or vim.fn.fnamemodify(harpoon_file_path, ":t")

        if current_file_path == harpoon_file_path then
          contents[index] = string.format(
            "%%#HarpoonNumberActive# %s. %%#HarpoonActive#%s ",
            index,
            file_name
          )
        else
          contents[index] = string.format(
            "%%#HarpoonNumberInactive# %s. %%#HarpoonInactive#%s ",
            index,
            file_name
          )
        end
      end

      return table.concat(contents)
    end

    vim.opt.showtabline = 2
    vim.api.nvim_create_autocmd(
      { "BufEnter", "BufAdd", "User", "CursorMoved" },
      {
        callback = function(ev)
          vim.o.tabline = Harpoon_files()
        end,
      }
    )

    vim.cmd("highlight! HarpoonInactive guibg=NONE guifg=#63698c")
    vim.cmd("highlight! HarpoonActive guibg=NONE guifg=white")
    vim.cmd("highlight! HarpoonNumberActive guibg=NONE guifg=#7aa2f7")
    vim.cmd("highlight! HarpoonNumberInactive guibg=NONE guifg=#7aa2f7")
    vim.cmd("highlight! TabLineFill guibg=NONE guifg=white")
  end,
}
