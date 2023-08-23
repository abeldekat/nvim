local Dynamic = require("misc.colorscheme")
local is_lazy = true
local is_cond = true

return {

  { -- has its own toggle_style
    "ribru17/bamboo.nvim",
    name = "colors_bamboo",
    main = "bamboo",
    opts = function()
      return { style = "vulgaris", toggle_style_key = "<leader>a" }
    end,
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

  { -- 6 flavours, no light theme
    "loctvl842/monokai-pro.nvim",
    name = "colors_monokai",
    main = "monokai-pro",
    config = function()
      local opts = {
        filter = "pro",
      }
      require("monokai-pro").setup(opts)
    end,
    lazy = is_lazy,
    cond = is_cond,
  },

  {
    "lunarvim/darkplus.nvim",
    name = "colors_darkplus",
    main = "darkplus",
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
}
