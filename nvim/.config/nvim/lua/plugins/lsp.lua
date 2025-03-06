return {
  {
    -- https://github.com/williamboman/mason.nvim
    "williamboman/mason.nvim",
    lazy = false,
    opts = {},
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

        --TODO: Debug warning
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text", -- show only symbol annotations
            maxwidth = {
              -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
              -- can also be a function to dynamically calculate max width such as
              -- menu = function() return math.floor(0.45 * vim.o.columns) end,
              menu = 50, -- leading text (labelDetails)
              abbr = 50, -- actual suggestion item
            },
            ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
            show_labelDetails = true, -- show labelDetails in menu. Disabled by default

            -- The function below will be called before any actual modifications from lspkind
            -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
            before = function(entry, vim_item)
              -- ...
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
          -- ["<C-f>"] = cmp.mapping.luasnip_jump_forward(),
          -- ["<C-b>"] = cmp.mapping.luasnip_jump_backward(),
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
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    init = function()
      -- Reserve a space in the gutter
      -- This will avoid an annoying layout shift in the screen
      vim.opt.signcolumn = "yes"
    end,
    config = function()
      local lsp_defaults = require("lspconfig").util.default_config

      -- Add cmp_nvim_lsp capabilities settings to lspconfig
      -- This should be executed before you configure any language server
      lsp_defaults.capabilities = vim.tbl_deep_extend(
        "force",
        lsp_defaults.capabilities,
        require("cmp_nvim_lsp").default_capabilities()
      )

      require("lspconfig").rust_analyzer.setup({
        -- Other Configs ...
        settings = {
          ["rust-analyzer"] = {
            -- Other Settings ...
            procMacro = {
              ignored = {
                leptos_macro = {
                  -- optional: --
                  -- "component",
                  "server",
                },
              },
            },
          },
        },
      })
      -- LspAttach is where you enable features that only work
      -- if there is a language server active in the file
      vim.api.nvim_create_autocmd("LspAttach", {
        desc = "LSP actions",
        callback = function(event)
          local opts = { buffer = event.buf }

          vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
          vim.keymap.set(
            "n",
            "gd",
            "<cmd>lua vim.lsp.buf.definition()<cr>",
            opts
          )
          vim.keymap.set(
            "n",
            "gD",
            "<cmd>lua vim.lsp.buf.declaration()<cr>",
            opts
          )
          vim.keymap.set(
            "n",
            "gi",
            "<cmd>lua vim.lsp.buf.implementation()<cr>",
            opts
          )
          vim.keymap.set(
            "n",
            "go",
            "<cmd>lua vim.lsp.buf.type_definition()<cr>",
            opts
          )
          vim.keymap.set(
            "n",
            "gr",
            "<cmd>lua vim.lsp.buf.references()<cr>",
            opts
          )
          vim.keymap.set(
            "n",
            "gs",
            "<cmd>lua vim.lsp.buf.signature_help()<cr>",
            opts
          )
          vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
          vim.keymap.set(
            { "n", "x" },
            "<F3>",
            "<cmd>lua vim.lsp.buf.format({async = true})<cr>",
            opts
          )
          vim.keymap.set(
            "n",
            "<F4>",
            "<cmd>lua vim.lsp.buf.code_action()<cr>",
            opts
          )
        end,
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
          "pyright",
          "eslint@4.8.0",
          "tailwindcss",
          "yamlls",
        },

        automatic_installation = false,

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

          tailwindcss = function()
            require("lspconfig").tailwindcss.setup({

              filetypes = {
                "aspnetcorerazor",
                "astro",
                "astro-markdown",
                "blade",
                "clojure",
                "django-html",
                "htmldjango",
                "edge",
                "eelixir",
                "elixir",
                "ejs",
                "erb",
                "eruby",
                "gohtml",
                "gohtmltmpl",
                "haml",
                "handlebars",
                "hbs",
                "html",
                "htmlangular",
                "html-eex",
                "heex",
                "jade",
                "leaf",
                "liquid",
                "markdown",
                "mdx",
                "mustache",
                "njk",
                "nunjucks",
                "php",
                "razor",
                "slim",
                "twig",
                "css",
                "less",
                "postcss",
                "sass",
                "scss",
                "stylus",
                "sugarss",
                "javascript",
                "javascriptreact",
                "reason",
                "rescript",
                "rust",
                "typescript",
                "typescriptreact",
                "vue",
                "svelte",
                "templ",
              },
            })
          end,

          lua_ls = function()
            require("lspconfig").lua_ls.setup({})
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
