require("misc.colortoggle").add_toggle({
  name = "everforest",
  flavours = {
    { "dark", "soft" },
    { "dark", "medium" },
    { "dark", "hard" },
    { "light", "soft" },
    { "light", "medium" },
    { "light", "hard" },
  },
  toggle = function(flavour)
    vim.o.background = flavour[1]
    vim.g.everforest_background = flavour[2]
    vim.cmd.colorscheme("everforest")
  end,
})
return {}
