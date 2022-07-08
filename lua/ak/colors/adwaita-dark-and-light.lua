local toggler_factory = require "ak.core.keytoggler"
toggler_factory.reset_keys()
local bg = toggler_factory.background_toggler_adapter()

local palette_toggler = toggler_factory.new_palette_toggler({
  "dark",
  "darker",
}, "dark")

local function activate()
  if bg.is_background_dark() then
    vim.g.adwaita_darker = palette_toggler.value == "darker" or false
  end
  bg.apply_background()
  vim.cmd [[colorscheme adwaita]]
end
bg.on_toggle_background(activate)
palette_toggler:on_toggle(activate)

vim.cmd [[packadd color_adwaita.nvim]]
activate()
