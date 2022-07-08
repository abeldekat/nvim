--[[
not in use at the moment,
could be required as last step in lsp init
--]]

local function bootstrap_nlsp(opts)
  opts = opts or {}
  local lsp_settings_status_ok, lsp_settings = pcall(require, "nlspsettings")
  if lsp_settings_status_ok then
    lsp_settings.setup(opts)
  end
end

bootstrap_nlsp {
  append_default_schemas = true,
}
