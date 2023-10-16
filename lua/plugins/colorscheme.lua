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
local is_lazy = true

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
}
