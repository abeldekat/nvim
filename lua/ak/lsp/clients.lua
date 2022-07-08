--[[
"cmd_env" is intended to use the servers installed by nvim-lsp-installer
see scratch/lsp_installer_rethought.md
Rule of thumb: Every setup of an lsp adds one millisecond to startup time
--]]
local lspi = require "ak.lsp.from_lsp_installer"
local path_sumneko = { "sumneko_lua", "extension", "server", "bin" }
-- local path_ansiblels = { "ansiblels", "bin" }
local M = {}

--[[
TODO:
    name = "pyright",
    name = "texlab",
    name = "awk.ls",
--]]
-- stylua: ignore start
M.deferred = {
  { name = "vimls", cmd_env = function() return lspi.npm.env "vim" end, },
  { name = "jsonls", cmd_env = function() return lspi.npm.env "jsonls" end, },
}
M.active = {
  { name = "sumneko_lua", cmd_env = function() return lspi.custom.env(path_sumneko) end, },
  -- { name = "ansiblels", cmd_env = function() return lspi.custom.env(path_ansiblels) end, },
  { name = "ansiblels" },
  { name = "yamlls", cmd_env = function() return lspi.npm.env "yaml" end, },
  { name = "bashls", cmd_env = function() return lspi.npm.env "bash" end, },
}
-- stylua: ignore end
return M
