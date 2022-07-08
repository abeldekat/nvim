--[[ inspired by Atom One and Material, I'm trying to combine my favorite designs of them in this color scheme.--]]

local toggler_factory = require "ak.core.keytoggler"
toggler_factory.reset_keys()
local bg = toggler_factory.background_toggler_adapter()

local function create_palette_toggler()
  local function create_light_palette_toggler()
    return toggler_factory.new_palette_toggler({
      "default",
    }, "default")
  end
  local function create_dark_palette_toggler()
    return toggler_factory.new_palette_toggler({
      "default",
      "aura",
      "neon",
    }, "default")
  end

  return bg.by_background(create_dark_palette_toggler, create_light_palette_toggler)
end
local palette_toggler = create_palette_toggler()

local function activate()
  bg.apply_background()
  vim.g.edge_style = palette_toggler.value
  vim.cmd [[colorscheme edge]]
end
palette_toggler:on_toggle(activate)
bg.on_toggle_background(function()
  palette_toggler = create_palette_toggler()
  palette_toggler:on_toggle(activate)
  activate()
end)

vim.cmd [[packadd color_edge]]
vim.g.edge_enable_italic = 1
vim.g.edge_disable_italic_comment = 1
activate()

--[[
" The configuration options should be placed before `colorscheme edge`.
        let g:edge_style = 'aura'
        let g:edge_enable_italic = 1
        let g:edge_disable_italic_comment = 1
        colorscheme edge
--]]
