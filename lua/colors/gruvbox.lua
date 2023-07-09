require("misc.colortoggle").add_toggle({
  name = "gruvbox",
  flavours = {
    { "dark", "soft" },
    { "dark", "" },
    { "dark", "hard" },
    { "light", "soft" },
    { "light", "" },
    { "light", "hard" },
  },
  toggle = function(flavour)
    vim.o.background = flavour[1]
    require("gruvbox").setup({ contrast = flavour[2] })
    vim.cmd.colorscheme("gruvbox")
  end,
})

return {}
