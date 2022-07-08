--[[
  This color scheme is based on Monokai Pro, the contrast is adjusted to be a bit lower while keeping the colors vivid enough.
  The shusia, maia and espresso variants are basically modified versions of Monokai Pro.
]]

local toggler_factory = require "ak.core.keytoggler"

local palette_toggler = toggler_factory.new_palette_toggler({
  "default",
  "atlantis",
  "andromeda",
  "shusia",
  "maia",
  "espresso",
}, "espresso")

local function activate()
  vim.g.sonokai_style = palette_toggler.value
  vim.cmd [[colorscheme sonokai]]
end
palette_toggler:on_toggle(activate)

vim.cmd [[packadd color_sonokai]]
vim.g.sonokai_enable_italic = 1
vim.g.sonokai_disable_italic_comment = 1
activate()
