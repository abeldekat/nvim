local Dynamic = require("misc.colorscheme")
local is_lazy = true
local is_cond = true

return {

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

  {
    "rose-pine/neovim",
    name = "colors_rosepine",
    main = "rose-pine",
    opts = function()
      local opts = {
        variant = Dynamic.prefer_light and "dawn" or "moon",
        disable_italics = true,
      }
      return opts
    end,
    lazy = is_lazy,
    cond = is_cond,
  },

  { --nightfox has themes, no flavour options...
    "EdenEast/nightfox.nvim",
    name = "colors_nightfox",
    main = "nightfox",
    opts = function()
      require("nightfox.config").set_fox(Dynamic.prefer_light and "dawnfox" or "nordfox")
      local opts = {
        options = {
          dim_inactive = true,
        },
      }
      return opts
    end,
    lazy = is_lazy,
    cond = is_cond,
  },

  {
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

  { -- has its own toggle_style
    "navarasu/onedark.nvim",
    name = "colors_onedark",
    main = "onedark",
    opts = function()
      local style = Dynamic.prefer_light == true and "light" or "warm"
      local styles = {
        "warm",
        "light",
        "warmer",
        "dark",
        "darker",
        "cool",
        "deep",
      }
      return {
        toggle_style_key = "<leader>a",
        style = style,
        toggle_style_list = styles,
      }
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

  {
    "lunarvim/lunar.nvim",
    name = "colors_lunar",
    main = "lunar",
    lazy = is_lazy,
    cond = is_cond,
  },
}