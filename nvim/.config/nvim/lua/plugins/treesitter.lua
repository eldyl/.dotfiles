return {
  {
    -- https://github.com/nvim-treesitter/nvim-treesitter
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      {
        "andymass/vim-matchup",
        opts = function()
          -- https://github.com/hrsh7th/nvim-cmp/issues/1940#issuecomment-2241068952
          local ok, cmp = pcall(require, "cmp")
          if ok then
            cmp.event:on("menu_opened", function()
              vim.b.matchup_matchparen_enabled = false
            end)
            cmp.event:on("menu_closed", function()
              vim.b.matchup_matchparen_enabled = true
            end)
          end
        end,
        setup = function()
          vim.g.matchup_matchparen_offscreen = { method = "popup" }
        end,
      },
    },
    event = "BufRead",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        -- A list of parser names, or "all"
        ensure_installed = {
          "javascript",
          "typescript",
          "svelte",
          "astro",
          "vue",
          "tsx",
          "python",
          "html",
          "json",
          "dockerfile",
          "yaml",
          "markdown",
          "markdown_inline",
          "gitattributes",
          "gitcommit",
          "gitignore",
          "java",
          "css",
          "c",
          "vim",
          "vimdoc",
          "query",
          "lua",
          "bash",
          "rust",
          "c",
        },

        ignore_install = { "org" },
        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,
        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
        auto_install = true,

        highlight = {
          enable = true, -- `false` will disable the whole extension
        },
        matchup = {
          enable = true, -- mandatory, false will disable the whole extension
        },
      })
    end,
  },

  -- Parse html in rust files properly
  -- https://github.com/rayliwell/tree-sitter-rstml
  {
    "rayliwell/tree-sitter-rstml",
    dependencies = { "nvim-treesitter" },
    build = ":TSUpdate",
    config = function()
      require("tree-sitter-rstml").setup()
    end,
  },

  -- Auto create end tag for html elements
  -- https://github.com/windwp/nvim-ts-autotag
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
}
