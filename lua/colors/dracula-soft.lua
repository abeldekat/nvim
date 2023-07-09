require("misc.colortoggle").add_toggle({
  name = "dracula",
  flavours = {
    "dracula-soft",
    "dracula",
  },
  toggle = function(flavour)
    vim.cmd.colorscheme(flavour)
  end,
})

return {}
