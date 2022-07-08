--[[ https://github.com/Mofiqul/vscode.nvim a Lua port of vim-code-dark colorscheme ]]
-- Note: The light version is good...
local toggler_factory = require "ak.core.keytoggler"
toggler_factory.reset_keys()
local bg = toggler_factory.background_toggler_adapter()

local function switch()
  require("vscode").change_style(bg.get_current_value())
end
bg.on_toggle_background(switch)

vim.cmd [[packadd color_vscode.nvim]]

vim.g.vscode_style = bg.get_current_value()
-- Enable transparent background
-- Note: The example is wrong, should be a boolean or light is broken
vim.g.vscode_transparent = false
-- Enable italic comment
vim.g.vscode_italic_comment = 1
-- Disable nvim-tree background color
vim.g.vscode_disable_nvimtree_bg = false

vim.cmd [[colorscheme vscode]]
