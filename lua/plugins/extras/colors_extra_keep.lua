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
}
