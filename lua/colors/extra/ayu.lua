require("misc.colortoggle").add_toggle({
  name = "ayu",
  flavours = {
    "ayu-mirage",
    "ayu-dark",
    "ayu-light",
  },
  toggle = function(flavour)
    vim.cmd.colorscheme(flavour)
  end,
})

return {}
