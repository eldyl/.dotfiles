return {
  {
    -- Undo history visualizer
    -- https://github.com/mbbill/undotree
    "mbbill/undotree",
    event = "BufRead",
    keys = {
      { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Undo Tree Toggle" },
    },
  },
  {

    -- Easy comments
    "numToStr/Comment.nvim",
    event = "BufRead",
    config = function()
      require("Comment").setup()
    end,
  },
  {
    -- Editor config
    -- https://github.com/gpanders/editorconfig.nvim
    "gpanders/editorconfig.nvim",
    event = "BufRead",
  },
  {
    -- Indent blank lines
    -- https://github.com/lukas-reineke/indent-blankline.nvim
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "BufRead",
    config = function()
      local highlight = {
        "BlueThatBlends",
        "BlueStandOut",
      }

      local hooks = require("ibl.hooks")
      -- create the highlight groups in the highlight setup hook, so they are reset
      -- every time the colorscheme changes
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "BlueThatBlends", { fg = "#30465d" })
        vim.api.nvim_set_hl(0, "BlueStandOut", { fg = "#5379AD" })
      end)

      require("ibl").setup({
        indent = { char = "▎", highlight = highlight[1] },
        scope = {
          highlight = highlight[2], --[[show_start = false]]
        },
      })
    end,
  },
}
