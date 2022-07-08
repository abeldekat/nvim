--[[
  Even if plenary reload is present,
  still fall through if should reload is false
  Best approach: let shoud_reload always be true, let the caller decide
]]
local M = {}
local should_reload = true

local reloader = nil
if should_reload then
  local ok, plenary_reload = pcall(require, "plenary.reload")
  if ok then
    reloader = plenary_reload.reload_module
  end
end
reloader = reloader or require

-- Reload or require
M.reload = function(...)
  return reloader(...)
end

return M
