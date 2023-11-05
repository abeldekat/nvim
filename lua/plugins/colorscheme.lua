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
    name = "colors_rose-pine",
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
