local result = {
  { "neovim/nvim-lspconfig" },
  { "jose-elias-alvarez/null-ls.nvim" },

  { -- adds extra to sumneko-lua lsp:
    "folke/lua-dev.nvim",
    module = "lua-dev",
  },

  -- for jsonls, enable in jsonls lsp config
  -- has some startup consequences, less than 10ms:
  { "b0o/schemastore.nvim", opt = true },

  -- like coc-settings.json. for now, just for reference:
  { "tamago324/nlsp-settings.nvim", opt = true },

  -- only for installing:
  { "williamboman/nvim-lsp-installer", opt = true },
}

return result
