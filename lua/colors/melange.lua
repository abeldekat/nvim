require("misc.colortoggle").add_toggle({
  name = "melange",
  flavours = {
    "dark",
    "light",
  },
  toggle = function(flavour)
    vim.o.background = flavour
    vim.cmd.colorscheme("melange")
  end,
})

return {}
