--[[ A Dark Theme based on Atom One Dark Theme written in lua with TreeSitter syntax highlight. ]]
local toggler_factory = require "ak.core.keytoggler"
toggler_factory.reset_keys()
local bg = toggler_factory.background_toggler_adapter()

local function create_palette_toggler()
  local function create_light_palette_toggler()
    return toggler_factory.new_palette_toggler({
      "light",
    }, "light")
  end
  local function create_dark_palette_toggler()
    return toggler_factory.new_palette_toggler({
      "dark",
      "darker",
      "cool",
      "deep",
      "warm",
      "warmer",
    }, "warmer")
  end
  return bg.by_background(create_dark_palette_toggler, create_light_palette_toggler)
end
local palette_toggler = create_palette_toggler()

local config = {
  -- Main options --
  transparent = false, -- Show/hide background
  term_colors = true, -- Change terminal color as per the selected theme style
  ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
  -- toggle theme style ---
  toggle_style_key = "<nop>", --<leader>ts", -- Default keybinding to toggle
  toggle_style_list = { "dark", "darker", "cool", "deep", "warm", "warmer", "light" }, -- List of styles to toggle between

  -- Change code style ---
  -- Options are italic, bold, underline, none
  -- You can configure multiple style with comma seperated, For e.g., keywords = 'italic,bold'
  code_style = {
    comments = "italic",
    keywords = "none",
    functions = "none",
    strings = "none",
    variables = "none",
  },

  -- Custom Highlights --
  colors = {}, -- Override default colors
  highlights = {}, -- Override highlight groups

  -- Plugins Config --
  diagnostics = {
    darker = true, -- darker colors for diagnostic
    undercurl = true, -- use undercurl instead of underline for diagnostics
    background = true, -- use background color for virtual text
  },
}

local function activate()
  local onedark = require "onedark"
  bg.apply_background()

  config.style = palette_toggler.value
  onedark.setup(config)
  onedark.load()
end
palette_toggler:on_toggle(activate)
bg.on_toggle_background(function()
  palette_toggler = create_palette_toggler()
  palette_toggler:on_toggle(activate)
  activate()
end)

vim.cmd [[packadd color_onedark]]
activate()
