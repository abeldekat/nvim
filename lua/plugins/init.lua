--[[
Icons & colorscheme can be configured as options for the LazyVim plugin.

Each colorscheme has a corresponding file in the colors directory.
Purpose:
  - as an entry to dmenu selection
  - when applicable, setup <leader>a to switch palettes

Some colorschemes need to be activated with "load", because in the config
a default theme other than the plugin name has been configured
--]]

local use_load = { "nightfox", "onedark", "onedarkpro" }
local chosen = require("misc.colorscheme").color
return {
  -- { "folke/lazy.nvim", version = false },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = function()
        require("colors." .. chosen)
        if vim.tbl_contains(use_load, chosen) then
          require(chosen).load()
        else
          vim.cmd.colorscheme(chosen)
        end
      end,
    },
  },
}
