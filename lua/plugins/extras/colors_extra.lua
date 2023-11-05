local Dynamic = require("misc.colorscheme")
local is_lazy = true
local is_cond = true

return {

  { -- 6 flavours, no light theme
    "loctvl842/monokai-pro.nvim",
    name = "colors_monokai",
    main = "monokai-pro",
    config = function()
      local opts = {
        filter = "octagon",
      }
      require("monokai-pro").setup(opts)
    end,
    lazy = is_lazy,
    cond = is_cond,
  },

  { -- 6 styles, monokai variations
    "sainnhe/sonokai",
    name = "colors_sonokai",
    main = "sonokai",
    config = function()
      vim.g.sonokai_better_performance = 1
      vim.g.sonokai_enable_italic = 1
      vim.g.sonokai_disable_italic_comment = 1
      vim.g.sonokai_dim_inactive_windows = 1

      vim.g.sonokai_style = "andromeda"
    end,
    lazy = is_lazy,
    cond = is_cond,
  },

  {
    "AstroNvim/astrotheme",
    name = "colors_astrotheme",
    main = "astrotheme",
    opts = function()
      vim.o.background = Dynamic.prefer_light and "light" or "dark"
      local opts = {
        palette = Dynamic.prefer_light and "astrolight" or "astrodark",
      }
      return opts
    end,
    lazy = is_lazy,
    cond = is_cond,
  },

  { -- four themes. No visible difference between onedark and onedark_vivid
    "olimorris/onedarkpro.nvim",
    name = "colors_onedarkpro",
    main = "onedarkpro",
    opts = function()
      return {
        options = {
          cursorline = true,
          highlight_inactive_windows = true,
        },
      }
    end,
    config = function(_, opts)
      local theme = Dynamic.prefer_light and "onelight" or "onedark_vivid"
      require("onedarkpro").setup(opts)
      require("onedarkpro.config").set_theme(theme)
    end,
    lazy = is_lazy,
    cond = is_cond,
  },

  { -- dark and light with soft, medium and hard contrast. Three palettes.
    "sainnhe/gruvbox-material",
    name = "colors_gruvbox-material",
    main = "gruvbox-material",
    config = function()
      vim.g.gruvbox_material_better_performance = 1

      vim.o.background = Dynamic.prefer_light and "light" or "dark"
      vim.g.gruvbox_material_background = "soft"
      vim.g.gruvbox_material_foreground = "material"
    end,
    lazy = is_lazy,
    cond = is_cond,
  },

  { -- has its own toggle_style
    "ribru17/bamboo.nvim",
    name = "colors_bamboo",
    main = "bamboo",
    opts = function()
      vim.o.background = Dynamic.prefer_light and "light" or "dark"
      return {
        style = "vulgaris",
        toggle_style_key = "<leader>a",
        dim_inactive = true,
      }
    end,
    lazy = is_lazy,
    cond = is_cond,
  },
}
