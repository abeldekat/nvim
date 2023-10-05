local M = {}

local presets = {
  test = { "harpoon" },
}

-- only act on plenary when enabling plugins
-- other plugins might crash with plenary disabled
local when_enabling = {
  test = { "plenary" },
}

M.get_preset_keywords = function(name, enable_on_match)
  local result = presets[name]

  if result and enable_on_match then
    local extra = when_enabling[name]
    if extra then
      result = vim.list_extend(vim.list_extend({}, result), extra)
    end
  end
  return result or {}
end

M.return_spec = function(_) -- config
  return {}
end

return M
