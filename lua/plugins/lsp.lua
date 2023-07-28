--[[
-- semantic line numbers, ventilated prose:
-- prettierd instead of prettier, but:
-- extra_args do not work on prettierd
-- .prettierrc does work per project
-- nls.builtins.formatting.prettier.with({
--   extra_args = { "--prose-wrap", "always" },
-- }),
--]]
return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        bashls = {},
        marksman = {},
      },
    },
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      if type(opts.sources) == "table" then
        local nls = require("null-ls")
        vim.list_extend(opts.sources, {
          nls.builtins.diagnostics.markdownlint,
          nls.builtins.formatting.prettierd,
        })
      end
    end,
  },

  { -- lazyvim has stylua and shfmt
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "markdownlint",
        "prettierd",
      })
    end,
  },

  -- ---------------------------------------------
  -- adding ....
  -- ---------------------------------------------

  { -- from lazyvim example
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
    opts = {
      position = "right",
    },
  },
}
