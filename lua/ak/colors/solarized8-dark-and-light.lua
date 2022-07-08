local toggler_factory = require "ak.core.keytoggler"
toggler_factory.reset_keys()
local bg = toggler_factory.background_toggler_adapter()

local palette_toggler = toggler_factory.new_palette_toggler({
  "solarized8",
  "solarized8_low",
  "solarized8_flat",
  "solarized8_high",
}, "solarized8_flat")

local function activate()
  bg.apply_background()
  vim.cmd("colorscheme " .. palette_toggler.value)
end
palette_toggler:on_toggle(activate)
bg.on_toggle_background(activate)

vim.cmd [[packadd color_solarized8]]
activate()

-- --> Switch variants with telescope
-- Two implementations: Now using lifepillar/vim-solarized8

---------------------------------------------------------------------------
-- ----> 'lifepillar/vim-solarized8'
--
--[[
    solarized8_high: high-contrast variant (screenshow below, first column);
    solarized8: the default Solarized theme (screenshot below, second column);
    solarized8_low: low-contrast variant (screenshow below, third column);
    solarized8_flat: “flat” variant (screenshow below, fourth column).
The “flat” variant does not exist in the original Solarized.
It differs from solarized8 mainly in how the status line, split bars and tab bar look like
]]
---------------------------------------------------------------------------
-- 'ishan9299/nvim-solarized-lua'
--
-- little strange implementation, warnings in the code...

-- default options:
-- vim.g.solarized_italics = 1
-- vim.g.solarized_visibility = 'normal'
-- vim.g.solarized_diffmode = 'normal'
-- termtrans
-- vim.g.solarized_statusline = 'normal'
--
-- vim.cmd('colorscheme solarized-high')
-- vim.cmd('colorscheme solarized-flat')
-- vim.cmd('colorscheme solarized-low')
--
-- --> Strange, the colorscheme is called solarized instead of solarized8
-- vim.cmd('set background=dark')
-- vim.cmd('colorscheme solarized')
