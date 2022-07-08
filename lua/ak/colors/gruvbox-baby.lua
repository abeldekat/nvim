local toggler_factory = require "ak.core.keytoggler"
toggler_factory.reset_keys()

local contrast_toggler = toggler_factory.new_contrast_toggler({
  "medium",
  "dark",
}, "medium")

-- no palette, but a switch for transparant_mode
local transparant_toggler = toggler_factory.new_palette_toggler({
  false,
  true,
}, false)

local function activate()
  vim.g.gruvbox_baby_background_color = contrast_toggler.value
  vim.g.gruvbox_baby_transparent_mode = transparant_toggler.value
  vim.cmd [[colorscheme gruvbox-baby]]
end
contrast_toggler:on_toggle(activate)
transparant_toggler:on_toggle(activate)

-- Example config in Lua, defaults:
vim.g.gruvbox_baby_function_style = "bold"
vim.g.gruvbox_baby_keyword_style = "italic"
vim.g.gruvbox_baby_comment_style = "italic"
vim.g.gruvbox_baby_variable_style = "NONE"

-- Each highlight group must follow the structure:
-- ColorGroup = {fg = "foreground color", bg = "background_color", style = "some_style(:h attr-list)"}
-- See also :h highlight-guifg
-- Example:
-- vim.g.gruvbox_baby_highlights = { Normal = { fg = "#123123", bg = "NONE", style = "underline" } }

-- If you want access to the palette you have to do this:
-- local colors = require("gruvbox-baby.colors").config()
-- vim.g.gruvbox_baby_highlights = { Normal = { fg = colors.orange } }

-- Enable telescope theme
vim.g.gruvbox_baby_telescope_theme = true

-- Load the colorscheme
vim.cmd [[packadd color_gruvbox-baby]]
activate()
