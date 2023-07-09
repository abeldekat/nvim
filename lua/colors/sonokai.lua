require("misc.colortoggle").add_toggle({
  name = "sonokai",
  flavours = {
    "andromeda",
    "espresso",
    "atlantis",
    "shusia",
    "maia",
    "default",
  },
  toggle = function(flavour)
    vim.g.sonokai_style = flavour
    vim.cmd.colorscheme("sonokai")
  end,
})

return {}
