--[[

  Telescope FZY is builtin, can also be native:
  { "nvim-telescope/telescope-fzy-native.nvim" },
  Tested:
  { "nvim-telescope/telescope-smart-history.nvim" },
  { "nvim-telescope/telescope-cheat.nvim" },

]]

--[[
Load telescope on first require.
Chain the loading of dependant plugins
On the last plugin, setup telescope
]]

local result = {
  {
    "nvim-telescope/telescope.nvim",
    module = "telescope",
  },

  {
    "nvim-telescope/telescope-fzf-native.nvim",
    after = "telescope.nvim",
    run = "make",
  },

  {
    "nvim-telescope/telescope-ui-select.nvim",
    after = "telescope-fzf-native.nvim",
  },

  {
    "tami5/sqlite.lua",
    after = "telescope-ui-select.nvim",
  },

  {
    "nvim-telescope/telescope-frecency.nvim",
    after = "sqlite.lua",
  },

  {
    "AckslD/nvim-neoclip.lua",
    after = "telescope-frecency.nvim",
    config = function()
      require "ak.telescope.setup"
    end,
  },
}

return result
