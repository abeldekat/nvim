-- Test:askify/visual_studio_code
-- Test:talha-akram/noctis.nvim
-- Test:verf/deepwhite.nvim

local Dynamic = require("misc.colorscheme")
local is_lazy = true
local is_cond = true

return {

  { --combi dark and light ("", low, flat, hight). Skip high
    "lifepillar/vim-solarized8",
    name = "colors_solarized8",
    main = "vim-solarized8",
    branch = "neovim",
    config = function()
      vim.o.background = Dynamic.prefer_light and "light" or "dark"
    end,
    lazy = is_lazy,
    cond = is_cond,
  },

  { -- dark with medium and hard contrast
    "luisiacc/gruvbox-baby",
    name = "colors_gruvboxbaby",
    main = "gruvbox-baby",
    config = function()
      vim.g.gruvbox_baby_use_original_palette = false
      vim.g.gruvbox_baby_function_style = "bold"
      vim.g.gruvbox_baby_keyword_style = "italic"
      vim.g.gruvbox_baby_comment_style = "italic"
      vim.g.gruvbox_baby_comment_style = "italic"
      vim.g.gruvbox_baby_variable_style = "NONE"
      vim.g.gruvbox_baby_telescope_theme = true
      vim.g.gruvbox_baby_transparent_mode = false

      vim.g.gruvbox_baby_background_color = "medium"
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

  { -- combi (dark, light) and (soft, medium, hard)
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

  { --combi dark(default, aura and neon) and  light(default)
    "sainnhe/edge",
    name = "colors_edge",
    main = "edge",
    config = function()
      vim.g.edge_better_performance = 1
      vim.g.edge_enable_italic = 1

      vim.o.background = Dynamic.prefer_light and "light" or "dark"
      vim.g.edge_style = "default"
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

  { -- combi (dark, light) and (low, medium, high)
    "daschw/leaf.nvim",
    name = "colors_leaf",
    main = "leaf",
    config = function()
      local opts = {
        contrast = "medium",
      }
      vim.o.background = Dynamic.prefer_light and "light" or "dark"
      require("leaf").setup(opts)
    end,
    lazy = is_lazy,
    cond = is_cond,
  },

  { -- ibm colors
    "nyoom-engineering/oxocarbon.nvim",
    name = "colors_oxocarbon",
    main = "oxocarbon",
    config = function()
      vim.o.background = Dynamic.prefer_light and "light" or "dark"
    end,
    lazy = is_lazy,
    cond = is_cond,
  },
}
