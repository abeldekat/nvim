-- when activating extra, also change the max-depth in dmenu script
local Dynamic = require("misc.colorscheme")
local is_lazy = true
local is_cond = true

return {

  { -- the light theme is good... Gruvbox like
    "rebelot/kanagawa.nvim",
    name = "colors_kanagawa",
    main = "kanagawa",
    config = function()
      -- light bg -> lotus, dark bg -> wave
      vim.o.background = Dynamic.prefer_light and "light" or "dark"

      if Dynamic.prefer_light then
        require("kanagawa").setup({
          overrides = function(colors)
            return {
              -- Improve FlashLabel:
              -- Substitute = { fg = theme.ui.fg, bg = theme.vcs.removed },
              Substitute = { fg = colors.theme.ui.fg_reverse, bg = colors.theme.vcs.removed },
            }
          end,
        })
      end
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

  { -- unique colors, light is a little bit vague
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
