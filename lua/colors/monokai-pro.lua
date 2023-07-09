require("misc.colortoggle").add_toggle({
  name = "monokai-pro",
  flavours = {
    "monokai-pro-octagon",
    "monokai-pro-default",
    "monokai-pro-machine",
    "monokai-pro-ristretto",
    "monokai-pro-spectrum",
    "monokai-pro-classic",
  },
  toggle = function(flavour)
    vim.cmd.colorscheme(flavour)
  end,
})
return {}
