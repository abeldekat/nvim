local Dynamic = require("misc.colorscheme")
local keys = {
  {
    "<leader>uC",
    function()
      require("lazyvim.util").telescope("colorscheme", { enable_preview = true })()
    end,
    desc = "Colorscheme with preview",
  },
}
local add_toggle = function(pattern, opts)
  vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = type(pattern) == string and { pattern } or pattern,
    callback = function()
      require("misc.colortoggle").add_toggle(opts)
    end,
  })
end

return {

  { -- the light theme is good... Gruvbox like
    "rebelot/kanagawa.nvim", -- light bg -> lotus, dark bg -> wave
    name = "colors_kanagawa",
    main = "kanagawa",
    keys = keys,
    opts = function()
      add_toggle("kanagawa*", {
        name = "kanagawa",
        flavours = { "kanagawa-wave", "kanagawa-dragon", "kanagawa-lotus" },
      })
      vim.o.background = Dynamic.prefer_light and "light" or "dark"
      -- stylua: ignore
      return Dynamic.prefer_light and {
            overrides = function(colors)
              return { -- Improve FlashLabel:
                -- Substitute = { fg = theme.ui.fg, bg = theme.vcs.removed },
                Substitute = { fg = colors.theme.ui.fg_reverse, bg = colors.theme.vcs.removed },
              }
            end,
          } or {}
    end,
  },

  { -- unique colors, light is a little bit vague
    "Shatur/neovim-ayu",
    name = "colors_ayu",
    main = "ayu",
    keys = keys,
    opts = function()
      add_toggle("ayu*", {
        name = "ayu",
        flavours = { "ayu-mirage", "ayu-dark", "ayu-light" },
      })
      vim.o.background = Dynamic.prefer_light and "light" or "dark"
      return { mirage = true, overrides = {} }
    end,
  },

  { --combi dark(default, aura and neon) and  light(default)
    "sainnhe/edge",
    name = "colors_edge",
    main = "edge",
    keys = keys,
    config = function()
      add_toggle("edge", {
        name = "edge",
        -- stylua: ignore
        flavours = {
          { "dark", "default" }, { "dark", "aura" }, { "dark", "neon" },
          { "light", "default" },
        },
        toggle = function(flavour)
          vim.o.background = flavour[1]
          vim.g.edge_style = flavour[2]
          vim.cmd.colorscheme("edge")
        end,
      })
      vim.g.edge_better_performance = 1
      vim.g.edge_enable_italic = 1
      vim.o.background = Dynamic.prefer_light and "light" or "dark"
      vim.g.edge_style = "default"
    end,
  },

  { -- based on Leaf KDE Plasma Theme
    "daschw/leaf.nvim",
    name = "colors_leaf",
    main = "leaf",
    keys = keys,
    opts = function()
      add_toggle("leaf", {
        name = "leaf",
        -- stylua: ignore
        flavours = {
          { "dark", "low" }, { "dark", "medium" }, { "dark", "high" },
          { "light", "low" }, { "light", "medium" }, { "light", "high" },
        },
        toggle = function(flavour)
          vim.o.background = flavour[1]
          require("leaf").setup({ contrast = flavour[2] })
          vim.cmd.colorscheme("leaf")
        end,
      })
      vim.o.background = Dynamic.prefer_light and "light" or "dark"
      return { contrast = "medium" }
    end,
  },

  {
    "AstroNvim/astrotheme",
    name = "colors_astrotheme",
    main = "astrotheme",
    keys = keys,
    opts = function()
      add_toggle("astro*", {
        name = "astrotheme",
        flavours = { "astrodark", "astromars", "astrolight" },
      })
      vim.o.background = Dynamic.prefer_light and "light" or "dark"
      return {
        palette = Dynamic.prefer_light and "astrolight" or "astrodark",
      }
    end,
  },
}
