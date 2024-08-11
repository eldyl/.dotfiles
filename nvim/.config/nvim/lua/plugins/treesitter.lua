return {
  {
    -- https://github.com/nvim-treesitter/nvim-treesitter
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      {
        "andymass/vim-matchup",
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
          "yaml",
          "markdown",
          "markdown_inline",
          "gitattributes",
          "gitcommit",
          "gitignore",
          "java",
          "css",
          "c",
          "lua",
          "bash",
          "rust",
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
}
