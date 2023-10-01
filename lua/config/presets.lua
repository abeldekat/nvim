local M = {}

local presets = {
  test = { "harp", "plen" },
}

local when_enabling = {}

M.get = function(name, enable_on_match)
  local result = presets[name]
  if not result then
    return {}
  end

  if enable_on_match then
    local extra = when_enabling[name]
    if extra then
      result = vim.list_extend({}, result)
      result = vim.list_extend(result, extra)
    end
  end
  return result
end

return M
