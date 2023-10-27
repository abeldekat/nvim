require("misc.colortoggle").add_toggle({
  name = "catppuccin",
  flavours = {
    "catppuccin-frappe",
    "catppuccin-mocha",
    "catppuccin-macchiato",
    "catppuccin-latte",
  },
  toggle = function(flavour)
    vim.cmd.colorscheme(flavour)
  end,
})

return {}
