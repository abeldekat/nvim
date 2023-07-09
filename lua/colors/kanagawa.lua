require("misc.colortoggle").add_toggle({
  name = "kanagawa",
  flavours = {
    "kanagawa-wave",
    "kanagawa-dragon",
    "kanagawa-lotus",
  },
  toggle = function(flavour)
    vim.cmd.colorscheme(flavour)
  end,
})
return {}
