--[[
  'Mofiqul/dracula.nvim',
  
  Dracula colorscheme for NEOVIM written in Lua

  If you are using lualine, you can also enable the provided theme:

  Make sure to set theme as 'dracula-nvim' as dracula already exists in lualine built in themes

]]

-- Example:
-- show the '~' characters after the end of buffers
-- vim.g.dracula_show_end_of_buffer = true
-- use transparent background
-- vim.g.dracula_transparent_bg = true
-- set custom lualine background color
-- vim.g.dracula_lualine_bg_color = "#44475a"

require("ak.core.keytoggler").reset_keys()
vim.cmd [[packadd color_dracula]]
vim.cmd [[colorscheme dracula]]
