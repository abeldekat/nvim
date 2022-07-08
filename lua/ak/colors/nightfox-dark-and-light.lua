local toggler_factory = require "ak.core.keytoggler"
toggler_factory.reset_keys()
local bg = toggler_factory.background_toggler_adapter()

local function create_palette_toggler()
  local function create_light_palette_toggler()
    return toggler_factory.new_palette_toggler({
      "dayfox",
      "dawnfox",
    }, "dawnfox")
  end
  local function create_dark_palette_toggler()
    return toggler_factory.new_palette_toggler({
      "nightfox",
      "nordfox",
      "duskfox",
      "terafox",
    }, "nordfox")
  end

  return bg.by_background(create_dark_palette_toggler, create_light_palette_toggler)
end
local palette_toggler = create_palette_toggler()

local config = {
  options = {
    -- Compiled file's destination location
    -- compile_path = util.join_paths(vim.fn.stdpath("cache"), "nightfox"),
    -- compile_file_suffix = "_compiled", -- Compiled file suffix
    transparent = false, -- Disable setting background
    terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*)
    dim_inactive = false, -- Non focused panes set to alternative background
    styles = { -- Style to be applied to different syntax groups
      comments = "NONE", --italic
      functions = "NONE", --italic, bold
      keywords = "NONE", --bod
      numbers = "NONE",
      strings = "NONE",
      types = "NONE",
      variables = "NONE",
    },
    inverse = { -- Inverse highlight for different types
      match_paren = false,
      visual = false,
      search = false,
    },
    modules = {
      barbar = false,
      cmp = true,
      dashboard = false,
      diagnostic = {
        enable = true,
        background = true,
      },
      fern = false,
      fidget = true,
      gitgutter = false,
      gitsigns = true,
      glyph_pallet = false,
      hop = false,
      illuminate = false,
      lightspeed = false,
      lsp_saga = false,
      lsp_trouble = true,
      modes = true,
      native_lsp = true,
      neogit = false,
      nvimtree = false,
      sneak = false,
      symbol_outline = false,
      telescope = true,
      treesitter = true,
      tsrainbow = true,
      whichkey = false,
    },
  },
}

local function activate()
  vim.cmd("colorscheme " .. palette_toggler.value)
end
palette_toggler:on_toggle(activate)
bg.on_toggle_background(function()
  palette_toggler = create_palette_toggler()
  palette_toggler:on_toggle(activate)
  activate()
end)

vim.cmd [[packadd color_nightfox]]
require("nightfox").setup(config)
activate()
