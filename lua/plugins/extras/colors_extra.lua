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

  { -- combi (dark, light) and (soft, medium, hard)
    -- lazygit colors are not always readable
    -- good light theme
    "sainnhe/everforest",
    name = "colors_everforest",
    main = "everforest",
    config = function()
      vim.g.everforest_better_performance = 1
      vim.g.everforest_enable_italic = 1

      vim.o.background = Dynamic.prefer_light and "light" or "dark"
      vim.g.everforest_background = "medium"
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

  { -- no good distinction between keyword = value
    "savq/melange-nvim",
    name = "colors_melange",
    main = "melange",
    opts = function()
      vim.o.background = Dynamic.prefer_light and "light" or "dark"
      return {}
    end,
    config = function() end, -- no setup
    lazy = is_lazy,
    cond = is_cond,
  },
}
