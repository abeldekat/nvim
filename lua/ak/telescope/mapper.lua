local M = {}
local reloader = require "ak.core.reloader"
local should_reload = false
local keymap_set = vim.keymap.set

-- Map and wrap if reloading is active
M.map = function(key, func, desc, buffer)
  local rhs = func
  if should_reload then
    rhs = function()
      reloader.reload "plenary"
      reloader.reload "telescope"
      reloader.reload "ak.telescope.setup"
      require "ak.telescope.setup"
      --ie:
      -- reloader.reload("ak.telescope.search")
      func()
    end
  end

  local opts = {
    silent = true,
    desc = "Telescope " .. desc,
  }
  if buffer then
    opts.buffer = 0
  end
  keymap_set("n", key, rhs, opts)
end

return M
