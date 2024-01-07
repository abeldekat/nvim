--[[
Number of themes: 12 + 2(tokyonight and catppuccin)

Best light themes:
  tokyonight
  catppuccin(latte is similar to tokyonight)
  solarized8
  gruvbox-material
  nightfox dawnfox
  gruvbox
  bamboo
  nano
  onedarkpro
  astrotheme
  rose-pine
  onedark
--]]

local Utils = require("misc.colorutils")
local prefer_light = require("misc.color").prefer_light

return {
  {
    "folke/tokyonight.nvim",
    keys = Utils.keys(),
    opts = function(_, opts)
      Utils.add_toggle("tokyonight*", {
        name = "tokyonight",
        flavours = { "tokyonight-storm", "tokyonight-moon", "tokyonight-night", "tokyonight-day" },
      })
      opts.dim_inactive = true
      -- Tokyonight has a day-brightness, default 0.3
      opts.style = prefer_light and "day" or "storm"
      -- only needed for light theme. Normal darktheme shows white as fg:
      -- change fg = c.fg into:
      if prefer_light then
        opts.on_highlights = function(hl, c)
          hl.FlashLabel = { bg = c.magenta2, bold = true, fg = c.bg }
        end
      end
    end,
  },

  {
    "catppuccin/nvim",
    keys = Utils.keys(),
    name = "catppuccin",
    opts = {
      integrations = { nvimtree = false, neotree = false, harpoon = true, dropbar = { enabled = false } },
    },
    config = function(_, opts)
      Utils.add_toggle("catppuccin*", {
        name = "catppuccin",
        flavours = { "catppuccin-frappe", "catppuccin-mocha", "catppuccin-macchiato", "catppuccin-latte" },
      })
      opts.flavour = prefer_light and "latte" or "frappe"
      require("catppuccin").setup(opts)
    end,
  },

  -- ---------------------------------------------
  -- Added
  -- ---------------------------------------------

  { --nightfox has themes, no flavour options...
    "EdenEast/nightfox.nvim",
    name = "colors_nightfox",
    main = "nightfox",
    keys = Utils.keys(),
    opts = function()
      Utils.add_toggle("*fox", {
        name = "nightfox",
        -- "carbonfox", "dayfox",
        flavours = { "nordfox", "nightfox", "duskfox", "terafox", "dawnfox" },
      })
      return { options = { dim_inactive = true } }
    end,
  },

  {
    "rose-pine/neovim",
    name = "colors_rose-pine",
    main = "rose-pine",
    keys = Utils.keys(),
    opts = function()
      Utils.add_toggle("rose-pine*", {
        name = "rose-pine",
        flavours = { "rose-pine-moon", "rose-pine-main", "rose-pine-dawn" },
      })
      return {
        variant = prefer_light and "dawn" or "moon",
        disable_italics = true,
      }
    end,
  },
}
