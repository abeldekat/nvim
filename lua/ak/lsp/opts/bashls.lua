local handlers = require "ak.lsp.handlers"
local opts = {
  capabilities = handlers.capabilities(),
  on_attach = function(client, bufnr)
    handlers.on_attach(client, bufnr)
    handlers.on_attach_formatting_opt_out(client, bufnr)
  end,
}
return opts

--[[
manual install:
npm i -g bash-language-server
previously invoked from after/ftplugin/sh.lua
homepage = "https://github.com/bash-lsp/bash-language-server",
--]]
