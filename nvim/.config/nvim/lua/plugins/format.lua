return {
  -- https://github.com/nvimdev/guard.nvim
  "nvimdev/guard.nvim",
  dependencies = {
    "nvimdev/guard-collection",
  },
  cmd = { "GuardFmt" },
  keys = {
    { "<leader>f", "<cmd>GuardFmt<cr>", desc = "Format Code" },
  },
  config = function()
    local ft = require("guard.filetype")

    ft("typescript,javascript,typescriptreact,javascriptreact,vue,svelte,json,jsonc"):fmt(
      "prettier"
    )

    ft("astro"):fmt({
      cmd = "pnpm",
      args = {
        "exec",
        "prettier",
        "--write ",
        ".",
        "--plugin=prettier-plugin-astro",
        "--plugin=prettier-plugin-tailwindcss",
      },
      fname = true,
      stdin = true,
    })

    ft("lua"):fmt("stylua")

    ft("rust"):fmt("rustfmt")

    ft("java"):fmt("google-java-format")

    -- Call setup() LAST!
    require("guard").setup({
      -- the only options for the setup function
      fmt_on_save = false,
      -- Use lsp if no formatter was defined for this filetype
      lsp_as_default_formatter = false,
    })
  end,
}
