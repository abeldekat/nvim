--[[
skipped:
"gruvbuddy"
"maxmx03/solarized.nvim", (bugs, preload)
"projekt0n/github-nvim-theme",
"Mofiqul/adwaita.nvim",
"Mofiqul/vscode.nvim",
"rmehri01/onenord.nvim", inconvenient setup, nightfox is better
--]]
local Dynamic = require("misc.colorscheme")
local lazy = true -- supplied by LazyVim
local lazy_one = true -- multiple plugins can coexist
local lazy_second = true -- multiple plugins might coexist
local lazy_third = true -- testing

local all = {

  -- ---------------------------------------------
  -- LazyVim
  -- ---------------------------------------------

  { -- add to LazyVim config
    "folke/tokyonight.nvim",
    opts = function(_, opts)
      opts.dim_inactive = true
      opts.style = Dynamic.prefer_light and "day" or "moon"
      -- only needed for light theme. Normal darktheme shows white as fg:
      -- change fg = c.fg into:
      if Dynamic.prefer_light then
        opts.on_highlights = function(hl, c)
          hl.FlashLabel = { bg = c.magenta2, bold = true, fg = c.bg }
        end
      end
    end,
    lazy = lazy,
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
    lazy = lazy,
  },

  -- ---------------------------------------------
  -- lazy one....
  -- ---------------------------------------------

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
    lazy = lazy_one,
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
    lazy = lazy_one,
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
    lazy = lazy_one,
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
    lazy = lazy_one,
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
    lazy = lazy_one,
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
    lazy = lazy_one,
  },

  { "lunarvim/lunar.nvim", name = "colors_lunar", main = "lunar", lazy = lazy_one },

  -- ---------------------------------------------
  -- lazy second....
  -- ---------------------------------------------

  { -- has its own toggle_style
    "ribru17/bamboo.nvim",
    name = "colors_bamboo",
    main = "bamboo",
    opts = function()
      return { style = "vulgaris", toggle_style_key = "<leader>a" }
    end,
    lazy = lazy_second,
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
    lazy = lazy_second,
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
    lazy = lazy_second,
  },

  { "lunarvim/darkplus.nvim", name = "colors_darkplus", main = "darkplus", lazy = lazy_second },

  { "lunarvim/onedarker.nvim", name = "colors_onedarker", main = "onedarker", lazy = lazy_second },

  {
    "Mofiqul/dracula.nvim",
    name = "colors_dracula",
    main = "dracula",
    lazy = lazy_second,
  },

  -- ---------------------------------------------
  -- lazy third....
  -- ---------------------------------------------

  { --combi dark and light ("", low, flat, hight). Skip high
    "lifepillar/vim-solarized8",
    name = "colors_solarized8",
    main = "vim-solarized8",
    branch = "neovim",
    config = function()
      vim.o.background = Dynamic.prefer_light and "light" or "dark"
    end,
    lazy = lazy_third,
  },

  { -- dark and light with soft, "", and hard contrast
    "ellisonleao/gruvbox.nvim",
    name = "colors_gruvbox",
    main = "gruvbox",
    opts = function()
      vim.o.background = Dynamic.prefer_light and "light" or "dark"
      return { contrast = "soft", italic = { strings = false } }
    end,
    lazy = lazy_third,
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
    lazy = lazy_third,
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
    lazy = lazy_third,
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
    lazy = lazy_third,
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
    lazy = lazy_third,
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
    lazy = lazy_third,
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
    lazy = lazy_third,
  },

  { -- ibm colors
    "nyoom-engineering/oxocarbon.nvim",
    name = "colors_oxocarbon",
    main = "oxocarbon",
    config = function()
      vim.o.background = Dynamic.prefer_light and "light" or "dark"
    end,
    lazy = lazy_third,
  },
}
return all
