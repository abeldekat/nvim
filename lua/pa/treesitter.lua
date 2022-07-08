--[[
Treesitter plugins should not be optional
]]

local disable = {
  autotag = true, -- not in tj's config
  rainbow = true,
}
local result = {
  {
    "nvim-treesitter/nvim-treesitter",
  },

  { "JoosepAlviste/nvim-ts-context-commentstring" },

  { "nvim-treesitter/playground" },

  { "nvim-treesitter/nvim-treesitter-textobjects" },

  -- Formerly nvim-ts-hint-textobject
  { "mfussenegger/nvim-treehopper" },

  { --Use treesitter to autoclose and autorename html tag:
    "windwp/nvim-ts-autotag",
    ft = { "html" },
    disable = disable.autotag,
  },

  { -- Rainbow parentheses
    "p00f/nvim-ts-rainbow",
    disable = disable.rainbow,
  },
}
return result
