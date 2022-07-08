--[[
Neovim colorscheme based on Leaf KDE Plasma Theme. Technically based on kanagawa
]]
local toggler_factory = require "ak.core.keytoggler"
toggler_factory.reset_keys()
local bg = toggler_factory.background_toggler_adapter()

local function create_contrast_toggler()
  local function create_light_contrast_toggler()
    return toggler_factory.new_contrast_toggler({
      "light",
      "lighter",
      "lightest",
    }, "lightest")
  end
  local function create_dark_contrast_toggler()
    return toggler_factory.new_contrast_toggler({
      "dark",
      "darker",
      "darkest",
    }, "dark")
  end

  return bg.by_background(create_dark_contrast_toggler, create_light_contrast_toggler)
end
local contrast_toggler = create_contrast_toggler()

--- default config
local config = {
  undercurl = true,
  commentStyle = "italic",
  functionStyle = "NONE",
  -- keywordStyle = "italic",
  keywordStyle = "NONE",
  statementStyle = "bold",
  typeStyle = "NONE",
  -- variablebuiltinStyle = "italic",
  variablebuiltinStyle = "NONE",
  transparent = false,
  colors = {},
  overrides = {},
}

local function activate()
  config.theme = contrast_toggler.value
  require("leaf").setup(config)
  vim.cmd "colorscheme leaf"
end
contrast_toggler:on_toggle(activate)
bg.on_toggle_background(function()
  contrast_toggler = create_contrast_toggler()
  contrast_toggler:on_toggle(activate)
  activate()
end)

vim.cmd [[packadd color_leaf.nvim]]
activate()
