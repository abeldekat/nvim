--[[
Number of themes: 14 + 2(tokyonight and catppuccin)

Best light themes:
  tokyonight
  solarized8
  gruvbox-material
  nightfox dawnfox
  everforest
  gruvbox
  bamboo
  nano
  kanagawa
  onedarkpro
  astrotheme
  rose-pine
  onedark
  catppuccin(latte is similar to tokyonight)
--]]

local Dynamic = require("misc.colorscheme")
local is_lazy = true
local is_cond = true

return {

  -- ---------------------------------------------
  -- LazyVim
  -- ---------------------------------------------

  { -- add to LazyVim config
    "folke/tokyonight.nvim",
    opts = function(_, opts)
      opts.dim_inactive = true
      opts.style = Dynamic.prefer_light and "day" or "storm"
      -- only needed for light theme. Normal darktheme shows white as fg:
      -- change fg = c.fg into:
      if Dynamic.prefer_light then
        opts.on_highlights = function(hl, c)
          hl.FlashLabel = { bg = c.magenta2, bold = true, fg = c.bg }
        end
      end
    end,
    lazy = is_lazy,
  },

  { -- add to LazyVim config
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      integrations = {
        nvimtree = false,
        neotree = false,
        harpoon = true,
        dropbar = {
          enabled = false,
        },
      },
    },
    config = function(_, opts)
      opts.flavour = Dynamic.prefer_light and "latte" or "frappe"
      require("catppuccin").setup(opts)
    end,
    lazy = is_lazy,
  },

  -- ---------------------------------------------
  -- Added
  -- ---------------------------------------------

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
      local style = Dynamic.prefer_light == true and "light" or "dark"
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

  { -- dark and light with soft, "", and hard contrast
    "ellisonleao/gruvbox.nvim",
    name = "colors_gruvbox",
    main = "gruvbox",
    opts = function()
      vim.o.background = Dynamic.prefer_light and "light" or "dark"
      return { contrast = "soft", italic = { strings = false } }
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

  { -- very few colors, solarized look
    "ronisbr/nano-theme.nvim",
    name = "colors_nano",
    main = "nano-theme",
    opts = function()
      vim.o.background = Dynamic.prefer_light and "light" or "dark"
      return {}
    end,
    config = function() end, -- no setup in init
    lazy = is_lazy,
    cond = is_cond,
  },
}
