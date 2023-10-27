require("misc.colortoggle").add_toggle({
  name = "nano-theme",
  flavours = {
    "dark",
    "light",
  },
  toggle = function(flavour)
    vim.o.background = flavour
    vim.cmd.colorscheme("nano-theme")
  end,
})

return {}
