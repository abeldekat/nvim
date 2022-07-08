local M = {}
local B = {}
local Toggler = require "ak.core.toggler"

local active_background = "dark"
-- local active_background = "light"
-- always set on M by B
local toggler = nil

function M.get_current_value()
  return toggler.value
end

function M.is_background_dark()
  return (toggler.value == "dark") or false
end

function M.on_toggle_background(cb)
  toggler:on_toggle(cb)
end

function M.apply_background()
  vim.cmd("set background=" .. toggler.value)
end

function M.toggle_background_preference()
  if active_background == "dark" then
    active_background = "light"
  else
    active_background = "dark"
  end
  vim.notify("Background preference is set to: " .. active_background)
end

function M.by_background(cb_dark_toggler, cb_light_toggler)
  if toggler.value == "dark" then
    return cb_dark_toggler()
  end
  return cb_light_toggler()
end

-- builder
function B.build(bg_keybinding)
  toggler = Toggler:new({
    "dark",
    "light",
  }, active_background)
  vim.keymap.set("n", bg_keybinding, function()
    toggler:toggle()
  end, { desc = "background color options" })

  return M
end

return B
