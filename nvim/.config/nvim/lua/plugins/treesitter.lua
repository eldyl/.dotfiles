return {
  {
    -- https://github.com/nvim-treesitter/nvim-treesitter
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    lazy = false,
    build = ":TSUpdate",
    init = function()
      require("nvim-treesitter.configs").setup({
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
          "toml",
          "yaml",
          "markdown",
          "markdown_inline",
          "gitattributes",
          "gitcommit",
          "comment",
          "diff",
          "gitignore",
          "java",
          "css",
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
      })
    end,
  },

  -- https://github.com/andymass/vim-matchup
  {
    "andymass/vim-matchup",
    dependencies = { "nvim-treesitter" },
    opts = function()
      -- vim.g.matchup_treesitter_stopline = 500
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
    init = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },

  -- Parse html in rust files properly
  -- https://github.com/rayliwell/tree-sitter-rstml
  {
    "rayliwell/tree-sitter-rstml",
    dependencies = { "nvim-treesitter" },
    ft = "rust",
    build = ":TSUpdate",
    config = function()
      require("tree-sitter-rstml").setup()
    end,
  },

  -- Auto create end tag for html elements
  -- https://github.com/windwp/nvim-ts-autotag
  {
    "windwp/nvim-ts-autotag",
    opts = {},
  },

  -- Auto pairing for brackets
  -- https://github.com/windwp/nvim-autopairs
  {
    "windwp/nvim-autopairs",
    dependencies = { "nvim-treesitter" },
    config = true,
    -- use opts = {} for passing setup options
    -- this is equivalent to setup({}) function
  },
}
