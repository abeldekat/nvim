local M = {}

local Toggler = require "ak.core.toggler"
-- KEY: Colors
-- local key_contrast = "<leader>mc"
local key_contrast = "<leader>s"

-- Typing mp is hard....
-- local key_palette = "<leader>mt"
local key_palette = "<leader>x"

-- local key_background = "<leader>m;"
local key_background = "<leader>z"

local key_background_preference = "<leader>Z"

function M.reset_keys()
  -- print "key reset"
  vim.keymap.set("n", key_contrast, function()
    print "NOOP contrast options"
  end, { desc = "NOOP: contrast color options" })
  vim.keymap.set("n", key_palette, function()
    print "NOOP palette options"
  end, { desc = "NOOP: palette color options" })
  vim.keymap.set("n", key_background, function()
    print "NOOP background options"
  end, { desc = "NOOP: background color options" })
  vim.keymap.set("n", key_background_preference, function()
    print "NOOP background preference options"
  end, { desc = "NOOP: background preference color options" })
end

function M.new_contrast_toggler(collection, value)
  local toggler = Toggler:new(collection, value)

  vim.keymap.set("n", key_contrast, function()
    toggler:toggle()
  end, { desc = "contrast color options" })

  return toggler
end

function M.new_palette_toggler(collection, value)
  local toggler = Toggler:new(collection, value)

  vim.keymap.set("n", key_palette, function()
    toggler:toggle()
  end, { desc = "palette color options" })

  return toggler
end

function M.background_toggler_adapter()
  local builder = require "ak.core.background"
  local background = builder.build(key_background)

  vim.keymap.set("n", key_background_preference, function()
    background.toggle_background_preference()
  end, { desc = "background preference options" })

  return background
end

return M
