--[[
Persistent theme: Using sed to update this file
All themes are optional.
git update-index --no-assume-unchanged after/plugin/colorscheme.lua
git update-index --assume-unchanged after/plugin/colorscheme.lua
--]]

-- --> using sed to change the theme...
-- stylua: ignore start
local color = 'gruvbox-material-dark-and-light'
-- stylua: ignore end
-- --> end using sed to change the theme...

pcall(function()
  require("ak.colors." .. color)
end)
