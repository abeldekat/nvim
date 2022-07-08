local toggler_factory = require "ak.core.keytoggler"
toggler_factory.reset_keys()
local bg = toggler_factory.background_toggler_adapter()

-- light: dawn, set on bg is light
local palette_toggler = toggler_factory.new_palette_toggler({
  "main",
  "moon",
}, "main")

local config = {
  bold_vert_split = false,
  dim_nc_background = true, -- false
  disable_background = false,
  disable_float_background = false,
  disable_italics = true,
  ---@usage string hex value or named color from rosepinetheme.com/palette
  groups = {
    background = "base",
    panel = "surface",
    border = "highlight_med",
    comment = "muted",
    link = "iris",
    punctuation = "subtle",

    error = "love",
    hint = "iris",
    info = "foam",
    warn = "gold",

    headings = {
      h1 = "iris",
      h2 = "foam",
      h3 = "rose",
      h4 = "gold",
      h5 = "pine",
      h6 = "foam",
    },
  },
}

local function activate()
  if bg.is_background_dark() then
    config.dark_variant = palette_toggler.value
  end
  bg.apply_background()
  require("rose-pine").setup(config)
  vim.cmd [[colorscheme rose-pine]]
end
palette_toggler:on_toggle(activate)
bg.on_toggle_background(activate)

vim.cmd [[packadd color_rose-pine]]
activate()
