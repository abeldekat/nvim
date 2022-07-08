local Toggler = {}
local Toggler_mt = { __index = Toggler }
function Toggler:new(collection, value)
  local obj = {}
  setmetatable(obj, Toggler_mt)

  obj.collection = collection
  obj.value = value
  return obj
end

function Toggler:on_toggle(callback)
  self.callback = callback
end

function Toggler:toggle()
  local function find_next(values, key)
    local index = {}
    for k, v in pairs(values) do
      index[v] = k
    end
    return values[index[key] + 1] or values[1]
  end

  local next = find_next(self.collection, self.value)
  local previous = self.value
  vim.defer_fn(function()
    vim.api.nvim_echo({ { string.format("Toggling [%s] into [%s]", previous, next), "InfoMsg" } }, false, {})
  end, 250)

  self.value = next
  if self.callback then
    self.callback()
  end
end

return Toggler
