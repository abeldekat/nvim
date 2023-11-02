--[[
-- semantic line numbers, ventilated prose: prettierd instead of prettier
-- however, prettierd extra_args do not work
--
-- per project: .prettierrc: 
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
}
