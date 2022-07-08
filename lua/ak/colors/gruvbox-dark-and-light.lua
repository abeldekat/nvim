--[[
https://github.com/gruvbox-community/gruvbox, This is a community fork of gruvbox
'ellisonleao/gruvbox.nvim', a port of gruvbox community theme to lua with treesitter support!
]]
local toggler_factory = require "ak.core.keytoggler"
toggler_factory.reset_keys()
local bg = toggler_factory.background_toggler_adapter()

local contrast_toggler = toggler_factory.new_contrast_toggler({
  "soft",
  "medium",
  "hard",
}, "hard")

local function activate()
  vim.g["gruvbox_contrast_" .. bg.get_current_value()] = contrast_toggler.value
  bg.apply_background()
  vim.cmd [[colorscheme gruvbox]]
end
bg.on_toggle_background(activate)
contrast_toggler:on_toggle(activate)

vim.cmd [[packadd lush.nvim]]
vim.cmd [[packadd color_gruvbox]]
activate()
