return {
  -- https://github.com/nvimdev/guard.nvim
  "nvimdev/guard.nvim",
  dependencies = {
    "nvimdev/guard-collection",
  },
  cmd = { "Guard fmt" },
  keys = {
    { "<leader>f", "<cmd>Guard fmt<cr>", desc = "Format Code" },
  },
  config = function()
    local ft = require("guard.filetype")

    ft(
      "typescript,javascript,typescriptreact,javascriptreact,vue,svelte,json,jsonc,yaml"
    ):fmt("prettier")

    ft("markdown,mdx"):fmt({
      cmd = "prettier",
      args = { "--write", "--prose-wrap", "always" },
      fname = true,
    })

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

    ft("toml"):fmt("taplo")

    ft("lua"):fmt("stylua")

    ft("rust"):fmt("rustfmt")

    ft("c"):fmt({
      cmd = "clang-format",
      args = { "--style={IndentWidth: 4}" },
      stdin = true,
    })

    ft("python"):fmt("black")

    ft("java"):fmt("google-java-format")

    vim.g.guard_config = {
      -- format on write to buffer
      fmt_on_save = false,
      -- use lsp if no formatter was defined for this filetype
      lsp_as_default_formatter = false,
      -- whether or not to save the buffer after formatting
      save_on_fmt = true,
    }
  end,
}
