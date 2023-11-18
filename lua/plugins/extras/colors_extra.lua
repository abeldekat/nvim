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

  { -- 6 styles, monokai variations
    "sainnhe/sonokai",
    name = "colors_sonokai",
    main = "sonokai",
    keys = keys,
    config = function()
      -- The shusia, maia and espresso variants are basically modified versions of Monokai Pro
      add_toggle("sonokai", {
        name = "sonokai",
        flavours = { "andromeda", "espresso", "atlantis", "shusia", "maia", "default" },
        toggle = function(flavour)
          vim.g.sonokai_style = flavour
          vim.cmd.colorscheme("sonokai")
        end,
      })
      vim.g.sonokai_better_performance = 1
      vim.g.sonokai_enable_italic = 1
      vim.g.sonokai_disable_italic_comment = 1
      vim.g.sonokai_dim_inactive_windows = 1
      vim.g.sonokai_style = "andromeda"
    end,
  },

  { -- 6 flavours, no light theme
    "loctvl842/monokai-pro.nvim",
    name = "colors_monokai",
    main = "monokai-pro",
    keys = keys,
    opts = function()
      add_toggle("monokai-pro*", {
        name = "monokai-pro",
        -- "monokai-pro-default", "monokai-pro-ristretto", "monokai-pro-spectrum",
        flavours = { "monokai-pro-octagon", "monokai-pro-machine", "monokai-pro-classic" },
      })
      return {
        filter = "octagon",
      }
    end,
  },

  { -- combi (dark, light) and (soft, medium, hard)
    -- lazygit colors are not always readable
    -- good light theme
    "sainnhe/everforest",
    name = "colors_everforest",
    main = "everforest",
    keys = keys,
    config = function()
      add_toggle("everforest", {
        name = "everforest",
        -- stylua: ignore
        flavours = {
          { "dark", "soft" }, { "dark", "medium" }, { "dark", "hard" },
          { "light", "soft" }, { "light", "medium" }, { "light", "hard" },
        },
        toggle = function(flavour)
          vim.o.background = flavour[1]
          vim.g.everforest_background = flavour[2]
          vim.cmd.colorscheme("everforest")
        end,
      })
      vim.g.everforest_better_performance = 1
      vim.g.everforest_enable_italic = 1
      vim.o.background = Dynamic.prefer_light and "light" or "dark"
      vim.g.everforest_background = "medium"
    end,
  },

  { -- dark and light with soft, medium and hard contrast. Three palettes.
    "sainnhe/gruvbox-material",
    name = "colors_gruvbox-material",
    main = "gruvbox-material",
    keys = keys,
    config = function()
      local name = "gruvbox-material"
      add_toggle("*material", {
        name = name,
        -- stylua: ignore
        flavours = {
          { "dark", "soft" }, { "dark", "medium" }, { "dark", "hard" },
          { "light", "soft" }, { "light", "medium" }, { "light", "hard" },
        },
        toggle = function(flavour)
          vim.o.background = flavour[1]
          vim.g.gruvbox_material_background = flavour[2]
          vim.cmd.colorscheme(name)
        end,
      })
      vim.g.gruvbox_material_foreground = "material" -- "mix", "original"
      vim.g.gruvbox_material_better_performance = 1
      vim.g.gruvbox_material_background = "soft"
      vim.g.gruvbox_material_foreground = "material"
      vim.o.background = Dynamic.prefer_light and "light" or "dark"
    end,
  },

  { -- has its own toggle_style
    "ribru17/bamboo.nvim",
    name = "colors_bamboo",
    main = "bamboo",
    keys = keys,
    opts = function() -- regular vulgaris greener multiplex light mode
      vim.o.background = Dynamic.prefer_light and "light" or "dark"
      return {
        style = "vulgaris",
        toggle_style_key = "<leader>a",
        dim_inactive = true,
      }
    end,
  },

  {
    "savq/melange-nvim",
    name = "colors_melange",
    main = "melange",
    keys = keys,
    config = function()
      add_toggle("melange", {
        name = "melange",
        flavours = { "dark", "light" },
        toggle = function(flavour)
          vim.o.background = flavour
          vim.cmd.colorscheme("melange")
        end,
      })
      vim.o.background = Dynamic.prefer_light and "light" or "dark"
    end,
  },
}
