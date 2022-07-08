local toggler_factory = require "ak.core.keytoggler"
toggler_factory.reset_keys()
local bg = toggler_factory.background_toggler_adapter()

local palette_toggler_for_dark = toggler_factory.new_palette_toggler({
  "storm",
  "night",
}, "night")

-- light is called day and is triggered by background
local contrast_toggler_for_light = toggler_factory.new_contrast_toggler({
  0.1,
  0.2,
  0.3,
  0.4,
  0.5,
}, 0.3)

local function activate()
  if bg.is_background_dark() then
    vim.g.tokyonight_style = palette_toggler_for_dark.value
  else
    vim.g.tokyonight_day_brightness = contrast_toggler_for_light.value
  end
  bg.apply_background()
  vim.cmd [[colorscheme tokyonight]]
end
palette_toggler_for_dark:on_toggle(activate)
contrast_toggler_for_light:on_toggle(function()
  package.loaded["tokyonight"] = nil
  package.loaded["tokyonight.theme"] = nil
  package.loaded["tokyonight.colors"] = nil
  package.loaded["tokyonight.util"] = nil
  package.loaded["tokyonight.config"] = nil

  activate()
end)
bg.on_toggle_background(activate)

vim.cmd [[packadd color_tokyonight]]
vim.g.tokyonight_sidebars = { "qf", "terminal", "packer", "lir" }
vim.g.tokyonight_lualineBold = true
-- Change the "hint" color to the "orange" color, and make the "error" color bright red
vim.g.tokyonight_colors = { hint = "orange", error = "#ff0000" }
activate()

--[[
The theme comes in three styles, storm, a darker variant night and day.

The day style will be used if:
    vim.g.tokyonight_style == "day"
    or vim.o.background == "light"

config = {
  style = opt("style", "storm"),
  dayBrightness = opt("day_brightness", 0.3),
  transparent = opt("transparent", false),
  commentStyle = opt("italic_comments", true) and "italic" or "NONE",
  keywordStyle = opt("italic_keywords", true) and "italic" or "NONE",
  functionStyle = opt("italic_functions", false) and "italic" or "NONE",
  variableStyle = opt("italic_variables", false) and "italic" or "NONE",
  hideInactiveStatusline = opt("hide_inactive_statusline", false),
  terminalColors = opt("terminal_colors", true),
  sidebars = opt("sidebars", {}),
  colors = opt("colors", {}),
  dev = opt("dev", false),
  darkFloat = opt("dark_float", true),
  darkSidebar = opt("dark_sidebar", true),
  transparentSidebar = opt("transparent_sidebar", false),
  transform_colors = false,
  lualineBold = opt("lualine_bold", false),
}
]]
