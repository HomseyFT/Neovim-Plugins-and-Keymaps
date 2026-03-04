return {
  -- LSP config
  {
    "neovim/nvim-lspconfig",
  },

  -- autocomplete
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",   -- LSP source
      "hrsh7th/cmp-buffer",     -- buffer completions
      "hrsh7th/cmp-path",       -- filesystem paths
      "hrsh7th/cmp-cmdline",    -- command line
      "L3MON4D3/LuaSnip",       -- snippets engine
      "saadparwaiz1/cmp_luasnip", -- snippet completions
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },

  -- syntax highlights
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    ensure_installed = {
      "python", "java", "javascript", "typescript",
      "c", "cpp", "rust", "asm", "go", "lua",
      "bash", "json", "yaml", "toml", "markdown",
      "html", "css",
    },
    auto_install = true,
  },

  -- telescope fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- file explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  -- colorscheme (sunset neon vibes)
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        term_colors = true,
        integrations = {
          treesitter = true,
          cmp = true,
          nvimtree = true,
          telescope = { enabled = true },
          native_lsp = {
            enabled = true,
          },
        },
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  -- dashboard
  {
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      dashboard.section.header.val = {
        [[                                                    ]],
        [[ ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗]],
        [[ ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║]],
        [[ ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║]],
        [[ ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║]],
        [[ ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║]],
        [[ ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
        [[                                                    ]],
      }

      dashboard.section.buttons.val = {
        dashboard.button("f", "  Find file",       ":Telescope find_files <CR>"),
        dashboard.button("r", "  Recent files",    ":Telescope oldfiles <CR>"),
        dashboard.button("g", "  Find word",       ":Telescope live_grep <CR>"),
        dashboard.button("e", "  New file",        ":ene <BAR> startinsert <CR>"),
        dashboard.button("c", "  Configuration",   ":e ~/.config/nvim/lua/plugins/init.lua <CR>"),
        dashboard.button("q", "  Quit",            ":qa<CR>"),
      }

      dashboard.section.header.opts.hl = "@keyword"
      dashboard.section.buttons.opts.hl = "@function"
      dashboard.section.footer.opts.hl = "@comment"

      dashboard.section.footer.val = "🌅 sunset.nvim"

      alpha.setup(dashboard.opts)
    end,
  },
}

