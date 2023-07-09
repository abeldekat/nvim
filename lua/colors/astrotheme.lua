-- no good lualine support
require("misc.colortoggle").add_toggle({
  name = "astrotheme",
  flavours = {
    "astrodark",
    "astromars",
    "astrolight",
  },
  toggle = function(flavour)
    vim.cmd.colorscheme(flavour)
  end,
})

return {}
