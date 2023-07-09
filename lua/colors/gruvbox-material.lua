local name = "gruvbox-material"

require("misc.colortoggle").add_toggle({
  name = name,
  flavours = {
    { "dark", "soft" },
    { "dark", "medium" },
    { "dark", "hard" },
    { "light", "soft" },
    { "light", "medium" },
    { "light", "hard" },
  },
  toggle = function(flavour)
    vim.o.background = flavour[1]
    vim.g.gruvbox_material_background = flavour[2]
    vim.cmd.colorscheme(name)
  end,
})
require("misc.colortoggle").add_toggle({
  name = name,
  key = "<leader>A",
  flavours = { -- 'palettes'
    "material",
    "mix",
    "original",
  },
  toggle = function(flavour)
    vim.g.gruvbox_material_foreground = flavour
    vim.cmd.colorscheme(name)
  end,
})

return {}
