local transformed =
  require("misc.lualine").transform(require("colors.solarized8_flat").lualine(vim.opt.background:get()))
return transformed
