--[[
https://github.com/morhetz/gruvbox, gruvbox is heavily inspired by badwolf, jellybeans and solarized.
Designed as a bright theme with pastel 'retro groove' colors and light/dark mode switching in the way of solarized.
"sainnhe/gruvbox-material", Gruvbox Material is a modified version of Gruvbox, the contrast is adjusted to be softer
]]
local toggler_factory = require "ak.core.keytoggler"
toggler_factory.reset_keys()
local bg = toggler_factory.background_toggler_adapter()

local palette_toggler = toggler_factory.new_palette_toggler({
  "original",
  "mix",
  "material",
}, "material")
local contrast_toggler = toggler_factory.new_contrast_toggler({
  "soft",
  "medium",
  "hard",
}, "hard")

local function activate()
  vim.g.gruvbox_material_background = contrast_toggler.value
  vim.g.gruvbox_material_palette = palette_toggler.value
  bg.apply_background()
  vim.cmd [[colorscheme gruvbox-material]]
end
bg.on_toggle_background(activate)
contrast_toggler:on_toggle(activate)
palette_toggler:on_toggle(activate)

-- let g:gruvbox_material_enable_italic = 1
-- let g:gruvbox_material_disable_italic_comment = 1
-- let g:gruvbox_material_enable_bold = 1
vim.cmd [[packadd color_gruvbox-material]]
activate()
