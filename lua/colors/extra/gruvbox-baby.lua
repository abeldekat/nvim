require("misc.colortoggle").add_toggle({
  name = "gruvbox-baby",
  flavours = {
    "medium",
    "dark",
  },
  toggle = function(flavour)
    vim.g.gruvbox_baby_background_color = flavour
    vim.cmd.colorscheme("gruvbox-baby")
  end,
})

return {}
