require("misc.colortoggle").add_toggle({
  name = "rose-pine",
  flavours = {
    "rose-pine-moon",
    "rose-pine-main",
    "rose-pine-dawn",
  },
  toggle = function(flavour)
    vim.cmd.colorscheme(flavour)
  end,
})

return {}
