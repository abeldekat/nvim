local handlers = require "ak.lsp.handlers"
local opts = {
  capabilities = handlers.capabilities(),
  on_attach = function(client, bufnr)
    handlers.on_attach(client, bufnr)
    -- handlers.formatting_on_attach(client, bufnr)
    handlers.on_attach_formatting_opt_out(client, bufnr)
  end,
}
return opts
