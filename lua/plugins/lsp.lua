return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- pyright = {},
        -- ruff_lsp = {},
        bashls = {},
        marksman = {},
      },
    },
  },

  { -- override opts.sources, removing fish
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      -- semantic line numbers, ventilated prose:
      -- prettierd instead of prettier, but:
      -- extra_args do not work on prettierd
      -- .prettierrc does work per project
      -- nls.builtins.formatting.prettier.with({
      --   extra_args = { "--prose-wrap", "always" },
      -- }),

      local nls = require("null-ls")
      opts.sources = {
        nls.builtins.formatting.stylua, -- LazyVim
        nls.builtins.formatting.shfmt, -- Lazyvim
        nls.builtins.formatting.black,
        nls.builtins.diagnostics.markdownlint,
        nls.builtins.formatting.prettierd,
      }
    end,
  },

  { -- lazyvim has stylua and shfmt
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "black",
        "markdownlint",
        "prettierd",
      })
    end,
  },

  -- ---------------------------------------------
  -- adding ....
  -- ---------------------------------------------
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
    opts = {
      position = "right",
    },
  },
}
