return {
  {
    -- TODO: Remove lsp-zero
    -- https://github.com/VonHeikemen/lsp-zero.nvim
    "VonHeikemen/lsp-zero.nvim",
    branch = "v4.x",
    lazy = true,
    config = false,
  },

  {
    -- https://github.com/williamboman/mason.nvim
    "williamboman/mason.nvim",
    lazy = true,
    config = true,
  },

  {
    -- https://github.com/hrsh7th/nvim-cmp
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      -- https://github.com/hrsh7th/cmp-buffer
      "hrsh7th/cmp-buffer",
      -- https://github.com/hrsh7th/cmp-path
      "hrsh7th/cmp-path",
      -- https://github.com/hrsh7th/cmp-nvim-lua
      "hrsh7th/cmp-nvim-lua",
      -- https://github.com/saadparwaiz1/cmp_luasnip
      "saadparwaiz1/cmp_luasnip",
      -- https://github.com/onsails/lspkind.nvim
      "onsails/lspkind-nvim",
      {
        -- https://github.com/L3MON4D3/LuaSnip
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        version = "2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp",

        dependencies = { "rafamadriz/friendly-snippets" },
      },
    },

    config = function()
      local cmp = require("cmp")
      local cmp_action = require("lsp-zero").cmp_action()
      local lspkind = require("lspkind")

      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({

        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
          end,
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),

        window = {
          documentation = cmp.config.window.bordered(),
        },

        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text", -- show only symbol annotations
            maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
            ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

            -- The function below will be called before any actual modifications from lspkind
            -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
            before = function(entry, vim_item)
              return vim_item
            end,
          }),
        },
        mapping = {
          ["<Down>"] = cmp.mapping.select_next_item({
            behavior = cmp.SelectBehavior.Insert,
          }),
          ["<Up>"] = cmp.mapping.select_prev_item({
            behavior = cmp.SelectBehavior.Insert,
          }),
          -- `Enter` key to confirm completion
          ["<CR>"] = cmp.mapping.confirm({ select = false }),

          -- Ctrl+Space to trigger completion menu
          ["<C-Space>"] = cmp.mapping.complete(),

          -- Navigate between snippet placeholder
          ["<C-f>"] = cmp_action.luasnip_jump_forward(),
          ["<C-b>"] = cmp_action.luasnip_jump_backward(),

          -- Scroll up and down in the completion documentation
          ["<C-u>"] = cmp.mapping.scroll_docs(-4),
          ["<C-d>"] = cmp.mapping.scroll_docs(4),
        },
      })
    end,
  },

  {
    -- https://github.com/neovim/nvim-lspconfig
    "neovim/nvim-lspconfig",
    cmd = { "LspInfo", "LspInstall", "LspStart" },
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      -- https://github.com/hrsh7th/cmp-nvim-lsp
      "hrsh7th/cmp-nvim-lsp",
      -- https://github.com/williamboman/mason-lspconfig.nvim
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      local lsp_zero = require("lsp-zero")

      local lsp_attach = function(client, bufnr)
        lsp_zero.default_keymaps({
          buffer = bufnr,
          preserve_mappings = false,
        })
      end

      lsp_zero.extend_lspconfig({
        lsp_attach = lsp_attach,
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
      })

      lsp_zero.ui({
        sign_text = {
          error = "✘",
          warn = "",
          hint = "󰌵",
          info = "",
        },
        float_border = "rounded",
      })

      require("mason-lspconfig").setup({
        ensure_installed = {
          "bashls",
          "lua_ls",
          "rust_analyzer",
          "ts_ls",
          "denols",
          "volar",
          "astro",
          "svelte",
          "eslint@4.8.0",
          "tailwindcss",
          "yamlls",
        },
        handlers = {
          function(server_name)
            require("lspconfig")[server_name].setup({})
          end,

          denols = function()
            require("lspconfig").denols.setup({
              on_attach = function(client)
                if
                  require("lspconfig").util.root_pattern(
                    "deno.json",
                    "import_map.json"
                  )(vim.fn.getcwd())
                then
                  if client.name == "ts_ls" then
                    client.stop()
                    return
                  end
                end
              end,
              root_dir = require("lspconfig").util.root_pattern(
                "deno.json",
                "deno.jsonc"
              ),
            })
          end,

          -- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/configure-volar-v2.md
          ts_ls = function()
            local vue_typescript_plugin = require("mason-registry")
              .get_package("vue-language-server")
              :get_install_path() .. "/node_modules/@vue/language-server" .. "/node_modules/@vue/typescript-plugin"

            require("lspconfig").ts_ls.setup({
              on_attach = function(client)
                if
                  require("lspconfig").util.root_pattern(
                    "deno.json",
                    "import_map.json"
                  )(vim.fn.getcwd())
                then
                  if client.name == "ts_ls" then
                    client.stop()
                    return
                  end
                end
              end,
              root_dir = require("lspconfig").util.root_pattern("package.json"),
              single_file_support = false,
              init_options = {
                plugins = {
                  {
                    name = "@vue/typescript-plugin",
                    location = vue_typescript_plugin,
                    languages = { "javascript", "typescript", "vue" },
                  },
                },
              },
              filetypes = {
                "javascript",
                "javascriptreact",
                "javascript.jsx",
                "typescript",
                "typescriptreact",
                "typescript.tsx",
                "vue",
              },
            })
          end,

          lua_ls = function()
            require("lspconfig").lua_ls.setup({
              on_init = function(client)
                lsp_zero.nvim_lua_settings(client, {})
              end,
            })
          end,
        },
      })
    end,
  },

  -- {
  --   -- Java...
  --   "mfussenegger/nvim-jdtls",
  --   ft = { "java" },
  -- },
}
