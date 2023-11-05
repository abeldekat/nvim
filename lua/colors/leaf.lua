--[[
Neovim colorscheme based on the awesome Leaf KDE Plasma Theme by @qewer33.
--]]
require("misc.colortoggle").add_toggle({
  name = "leaf",
  flavours = {
    { "dark", "low" },
    { "dark", "medium" },
    { "dark", "high" },
    { "light", "low" },
    { "light", "medium" },
    { "light", "high" },
  },
  toggle = function(flavour)
    vim.o.background = flavour[1]
    require("leaf").setup({ contrast = flavour[2] })
    vim.cmd.colorscheme("leaf")
  end,
})
return {}
