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
    opts = {
      servers = {
        bashls = {},
      },
    },
  },

  -- ---------------------------------------------
  -- adding ....
  -- ---------------------------------------------
}
