require("misc.colortoggle").add_toggle({
  name = "oxocarbon",
  flavours = {
    "dark",
    "light",
  },
  toggle = function(flavour)
    vim.opt.background = flavour
    vim.cmd.colorscheme("oxocarbon")
  end,
})

return {}
