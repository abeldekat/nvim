--[[
"marko-cerovac/material.nvim", https://material-theme.site/ A port of Material colorscheme
Note: The light theme is not good, too light
--]]
local toggler_factory = require "ak.core.keytoggler"
toggler_factory.reset_keys()
local bg = toggler_factory.background_toggler_adapter()

local function create_palette_toggler()
  local function create_light_palette_toggler()
    return toggler_factory.new_palette_toggler({
      "lighter",
    }, "lighter")
  end
  local function create_dark_palette_toggler()
    return toggler_factory.new_palette_toggler({
      "darker",
      "oceanic",
      "palenight",
      "deep ocean",
    }, "darker")
  end

  return bg.by_background(create_dark_palette_toggler, create_light_palette_toggler)
end
local palette_toggler = create_palette_toggler()

local config = {
  contrast = {
    sidebars = true,
    cursor_line = true,
  },
  italics = {
    comments = true,
    functions = true,
  },
  contrast_filetypes = {
    "terminal",
    "packer",
    "qf",
    "lir",
  },
  disable = {
    borders = true,
    eob_lines = true,
  },
  -- lualine_style = "stealth",
}

local function change_style()
  require("material.functions").change_style(palette_toggler.value)
end
palette_toggler:on_toggle(change_style)

bg.on_toggle_background(function()
  palette_toggler = create_palette_toggler()
  palette_toggler:on_toggle(change_style)
  change_style()
end)

vim.cmd [[packadd color_material]]
require("material").setup(config)
vim.g.material_style = palette_toggler.value
vim.cmd "colorscheme material"

--Lua, from the site:
--vim.api.nvim_set_keymap('n', '<leader>mm', [[<Cmd>lua require('material.functions').toggle_style()<CR>]], { noremap = true, silent = true })"Vim-Script
-- vim.api.nvim_set_keymap('n', '<leader>me', [[<Cmd>lua require('material.functions').toggle_eob()<CR>]], { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>ml', [[<Cmd>lua require('material.functions').change_style('lighter')<CR>]], { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>md', [[<Cmd>lua require('material.functions').change_style('darker')<CR>]], { noremap = true, silent = true })
