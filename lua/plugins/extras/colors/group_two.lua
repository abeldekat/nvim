local Dynamic = require("misc.colorscheme")
local is_lazy = true
local is_cond = true

return {

  {
    "lunarvim/darkplus.nvim",
    name = "colors_darkplus",
    main = "darkplus",
    lazy = is_lazy,
    cond = is_cond,
  },

  {
    "lunarvim/lunar.nvim",
    name = "colors_lunar",
    main = "lunar",
    lazy = is_lazy,
    cond = is_cond,
  },

  {
    "lunarvim/onedarker.nvim",
    name = "colors_onedarker",
    main = "onedarker",
    lazy = is_lazy,
    cond = is_cond,
  },

  {
    "Mofiqul/dracula.nvim",
    name = "colors_dracula",
    main = "dracula",
    lazy = is_lazy,
    cond = is_cond,
  },

  {
    "Shatur/neovim-ayu",
    name = "colors_ayu",
    main = "ayu",
    config = function()
      vim.o.background = Dynamic.prefer_light and "light" or "dark"
      local opts = {
        mirage = true, -- on dark choose mirage
        overrides = {},
      }
      require("ayu").setup(opts)
    end,
    lazy = is_lazy,
    cond = is_cond,
  },
}
