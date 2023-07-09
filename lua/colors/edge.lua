require("misc.colortoggle").add_toggle({
  name = "edge",
  flavours = {
    { "dark", "default" },
    { "dark", "aura" },
    { "dark", "neon" },
    { "light", "default" },
  },
  toggle = function(flavour)
    vim.o.background = flavour[1]
    vim.g.edge_style = flavour[2]
    vim.cmd.colorscheme("edge")
  end,
})

return {}
