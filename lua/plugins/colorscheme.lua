--[[
Number of themes: 12 + 2(tokyonight and catppuccin)

Best light themes:
  tokyonight
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
  catppuccin(latte is similar to tokyonight)
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

  { -- has its own toggle_style
    "navarasu/onedark.nvim",
    name = "colors_onedark",
    main = "onedark",
    keys = Utils.keys(),
    opts = function()
      return { -- the default is dark
        toggle_style_list = { "warm", "warmer", "light", "dark", "darker", "cool", "deep" },
        toggle_style_key = "<leader>a",
        style = "dark", -- ignored on startup, onedark.load must be used.
      }
    end,
  },

  {
    "ellisonleao/gruvbox.nvim",
    name = "colors_gruvbox",
    main = "gruvbox",
    keys = Utils.keys(),
    opts = function()
      Utils.add_toggle("gruvbox", {
        name = "gruvbox",
        -- stylua: ignore
        flavours = {
          { "dark", "soft" }, { "dark", "" }, { "dark", "hard" },
          { "light", "soft" }, { "light", "" }, { "light", "hard" },
        },
        toggle = function(flavour)
          vim.o.background = flavour[1]
          require("gruvbox").setup({ contrast = flavour[2] })
          vim.cmd.colorscheme("gruvbox")
        end,
      })
      vim.o.background = prefer_light and "light" or "dark"
      return { contrast = "soft", italic = { strings = false } }
    end,
  },

  {
    "lifepillar/vim-solarized8",
    name = "colors_solarized8",
    main = "vim-solarized8",
    branch = "neovim",
    keys = Utils.keys(),
    config = function()
      Utils.add_toggle("solarized8*", {
        name = "solarized8",
        -- stylua: ignore
        flavours = { -- solarized8_high not used
          { "dark", "solarized8_flat" }, { "dark", "solarized8_low" }, { "dark", "solarized8" },
          { "light", "solarized8_flat" }, { "light", "solarized8_low" }, { "light", "solarized8" },
        },
        toggle = function(flavour)
          vim.o.background = flavour[1]
          vim.cmd.colorscheme(flavour[2])
        end,
      })
      vim.o.background = prefer_light and "light" or "dark"
    end,
  },

  { -- very few colors, solarized look
    "ronisbr/nano-theme.nvim",
    name = "colors_nano",
    main = "nano-theme",
    keys = Utils.keys(),
    config = function()
      Utils.add_toggle("nano-theme", {
        name = "nano-theme",
        flavours = { "dark", "light" },
        toggle = function(flavour)
          vim.o.background = flavour
          vim.cmd.colorscheme("nano-theme")
        end,
      })
      vim.o.background = prefer_light and "light" or "dark"
      return {}
    end,
  },
}
