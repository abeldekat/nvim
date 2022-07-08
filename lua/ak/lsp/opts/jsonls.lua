local handlers = require "ak.lsp.handlers"
local use_schemastore = true

local schemas
if use_schemastore then
  -- has some startup consequences, less than 10ms:
  vim.cmd [[ packadd schemastore.nvim ]]
  -- A Neovim Lua plugin providing access to the [SchemaStore](https://github.com/SchemaStore/schemastore) catalog.
  -- https://github.com/SchemaStore/schemastore
  -- website:
  -- https://www.schemastore.org/json/
  schemas = require("schemastore").json.schemas()
else
  schemas = {}
end

local opts = {
  capabilities = handlers.capabilities(),
  on_attach = function(client, bufnr)
    handlers.on_attach(client, bufnr)
    handlers.on_attach_formatting_opt_in(client, bufnr)
  end,
  settings = {
    json = {
      schemas = schemas,
      validate = { enable = true },
      -- select = {
      --   ".eslintrc",
      --   "package.json",
      -- },
      -- ignore = {
      --   ".eslintrc",
      --   "package.json",
      -- },
    },
  },
  setup = {
    commands = {
      Format = {
        function()
          vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line "$", 0 })
        end,
      },
    },
  },
}
return opts

--[[
lspconfig
local bin_name = 'vscode-json-language-server'
local cmd = { bin_name, '--stdio' }
lspinstaller:
default_options = {
    cmd_env = npm.env(root_dir),
},
the root dir is ~/.local/nvim/lsp_servers/jsonls
cmd_env becomes ~/.local/nvim/lsp_servers/jsonls/node_modules/.bin
--]]
