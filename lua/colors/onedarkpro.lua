require("misc.colortoggle").add_toggle({
  name = "onedarkpro",
  flavours = {
    "onedark_vivid",
    "onedark",
    "onedark_dark",
    "onelight",
  },
  toggle = function(flavour)
    vim.cmd.colorscheme(flavour)
  end,
})

return {}
