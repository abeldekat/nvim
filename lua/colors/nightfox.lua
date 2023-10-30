require("misc.colortoggle").add_toggle({
  name = "nightfox",
  flavours = {
    "nordfox",
    "nightfox",
    "duskfox",
    "terafox",
    -- "carbonfox",
    -- "dayfox",
    "dawnfox",
  },
  toggle = function(flavour)
    vim.cmd.colorscheme(flavour)
  end,
})

return {}
