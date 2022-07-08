--[[
  -- TODO: Github-theme shows tabline when reloading....
]]
local toggler_factory = require "ak.core.keytoggler"
toggler_factory.reset_keys()
local bg = toggler_factory.background_toggler_adapter()

local function create_palette_toggler()
  local function create_light_palette_toggler()
    return toggler_factory.new_palette_toggler({
      "light",
      "light_default",
      -- "light_colorblind",
    }, "light_default")
  end
  local function create_dark_palette_toggler()
    return toggler_factory.new_palette_toggler({
      "dark",
      "dimmed",
      "dark_default",
      -- "dark_colorblind",
    }, "dark_default")
  end

  return bg.by_background(create_dark_palette_toggler, create_light_palette_toggler)
end
local palette_toggler = create_palette_toggler()

local config = {
  sidebars = { "qf", "terminal", "packer", "lir" },
  keyword_style = "NONE",
  function_style = "NONE",
  variable_style = "NONE",
  comment_style = "italic",
  overrides = function(c)
    return {
      CursorLine = { bg = c.bg_nc_statusline },
      ColorColumn = { bg = c.bg_nc_statusline },
    }
  end,
  -- Change the "hint" color to the "orange" color, and make the "error" color bright red
  -- colors = { hint = "orange", error = "#ff0000" },
}

local function activate()
  config.theme_style = palette_toggler.value
  require("github-theme").setup(config)
end
palette_toggler:on_toggle(activate)
bg.on_toggle_background(function()
  palette_toggler = create_palette_toggler()
  palette_toggler:on_toggle(activate)
  activate()
end)

vim.cmd [[packadd color_github-theme]]
activate()
