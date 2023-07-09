--[[
Tokyonight has a day-brightness, default 0.3
--]]
require("misc.colortoggle").add_toggle({
  name = "tokyonight",
  flavours = {
    "tokyonight-storm",
    "tokyonight-moon",
    "tokyonight-night",
    "tokyonight-day",
  },
  toggle = function(flavour)
    vim.cmd.colorscheme(flavour)
  end,
})

return {}
