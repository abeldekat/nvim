local handlers = require "ak.lsp.handlers"
local opts = {
  capabilities = handlers.capabilities(),
  on_attach = function(client, bufnr)
    handlers.on_attach(client, bufnr)
    handlers.on_attach_formatting_opt_in(client, bufnr)
  end,
  settings = {
    yaml = {
      hover = true,
      completion = true,
      validate = true,
      format = { -- default?
        enable = true,
      },
      -- When set to true the YAML language server will pull in all available schemas from JSON Schema Store
      -- jsonls, Use the schemastore plugin?
      schemaStore = {
        enable = true,
        url = "https://www.schemastore.org/api/json/catalog.json",
      },
      -- yaml.schemas: Helps you associate schemas with files in a glob pattern
      -- yaml.schemas applies a schema to a file. In other words, the schema (placed on the left) is applied to the glob pattern on the right.
      -- Your schema can be local or online. Your schema path must be relative to the project root and not an absolute path to the schema.
      -- schemas = {
      --   kubernetes = {
      --     "daemon.{yml,yaml}",
      --     "manager.{yml,yaml}",
      --     "restapi.{yml,yaml}",
      --     "role.{yml,yaml}",
      --     "role_binding.{yml,yaml}",
      --     "*onfigma*.{yml,yaml}",
      --     "*ngres*.{yml,yaml}",
      --     "*ecre*.{yml,yaml}",
      --     "*eployment*.{yml,yaml}",
      --     "*ervic*.{yml,yaml}",
      --     "kubectl-edit*.yaml",
      --   },
      -- },
    },
  },
}

return opts
