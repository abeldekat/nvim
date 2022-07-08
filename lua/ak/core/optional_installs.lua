--[[
Takes into account the use case for optional installs(packer optimized)
to be installed in start, for use without packer and in case of trouble with lazy loading
Does not require if an optional install is found because that would load at once
--]]

local M = {}
local fn = vim.fn

local opt_path = fn.stdpath "data" .. "/site/pack/packer/opt/"

local function in_opt(name)
  if fn.empty(fn.glob(opt_path .. name)) > 0 then
    return false
  end
  return true
end

function M.get_path(name)
  return opt_path .. name
end

-- If a package is installed in opt,
-- it is safe to proceed without requiring the package
--
-- Otherwise:
-- If the package is not installed in opt,
-- the package is not lazy loadable,
---and a normal require for presence is appropriate
function M.is_installed(pack_name, module_name)
  if not in_opt(pack_name) then
    -- print(pack_name .. " is not installed in opt...")
    -- not lazy loaded, so require is fine:
    local ok, _ = pcall(require, module_name)
    if not ok then
      -- print("require[" .. module_name .. "] failed for [" .. pack_name .. "]...")
      return false
    end
  end
  return true
end

return M
