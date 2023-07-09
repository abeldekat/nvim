require("misc.colortoggle").add_toggle({
  name = "solarized8",
  flavours = {
    { "dark", "solarized8_flat" },
    { "dark", "solarized8_low" },
    { "dark", "solarized8" },
    -- { "dark", "solarized8_high" },
    { "light", "solarized8_flat" },
    { "light", "solarized8_low" },
    { "light", "solarized8" },
    -- { "light", "solarized8_high" },
  },
  toggle = function(flavour)
    vim.o.background = flavour[1]
    vim.cmd.colorscheme(flavour[2])
  end,
})

return {}
