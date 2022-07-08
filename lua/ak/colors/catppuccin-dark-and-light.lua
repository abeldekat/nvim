--[[
    'catppuccin/nvim',
Warm mid-tone dark theme to show off your vibrant self!
Soothing pastel theme for the high-spirited!
]]

local toggler_factory = require "ak.core.keytoggler"
toggler_factory.reset_keys()
local bg = toggler_factory.background_toggler_adapter()

local function create_palette_toggler()
  local function create_light_palette_toggler()
    return toggler_factory.new_palette_toggler({
      "latte",
    }, "latte")
  end
  local function create_dark_palette_toggler()
    return toggler_factory.new_palette_toggler({
      "frappe",
      "macchiato",
      "mocha",
    }, "mocha")
  end

  return bg.by_background(create_dark_palette_toggler, create_light_palette_toggler)
end
local palette_toggler = create_palette_toggler()

local config = {
  transparent_background = false,
  term_colors = false,
  styles = {
    comments = "italic",
    conditionals = "italic",
    loops = "NONE",
    functions = "NONE",
    keywords = "NONE",
    strings = "NONE",
    variables = "NONE",
    numbers = "NONE",
    booleans = "NONE",
    properties = "NONE",
    types = "NONE",
    operators = "NONE",
  },
  integrations = {
    treesitter = true,
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = "italic",
        hints = "italic",
        warnings = "italic",
        information = "italic",
      },
      underlines = {
        errors = "underline",
        hints = "underline",
        warnings = "underline",
        information = "underline",
      },
    },
    lsp_trouble = true,
    cmp = true,
    lsp_saga = false,
    gitgutter = false,
    gitsigns = true,
    telescope = true,
    nvimtree = {
      enabled = false,
      show_root = false,
    },
    which_key = false,
    indent_blankline = {
      enabled = true,
      colored_indent_levels = true,
    },
    dashboard = false,
    neogit = false,
    vim_sneak = false,
    fern = false,
    barbar = false,
    bufferline = false,
    markdown = true,
    lightspeed = false,
    ts_rainbow = true,
    hop = false,
    notify = false,
    telekasten = false,
    symbols_outline = false,
    neotree = {
      enabled = false,
      show_root = false,
      transparent_panel = false,
    },
  },
}

local function activate()
  vim.g.catppuccin_flavour = palette_toggler.value
  require("catppuccin").setup(config)
  vim.cmd [[colorscheme catppuccin]]
end

palette_toggler:on_toggle(activate)
bg.on_toggle_background(function()
  palette_toggler = create_palette_toggler()
  palette_toggler:on_toggle(activate)
  activate()
end)

vim.cmd [[packadd color_catppuccin]]
activate()
