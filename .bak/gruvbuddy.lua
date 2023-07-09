-- { -- Flash is not clear...
--   "tjdevries/gruvbuddy.nvim",
--   name = "colors_gruvbuddy",
--   main = "gruvbuddy",
--   config = function()
--     require("colorbuddy").colorscheme("gruvbuddy")
--
--     local c = require("colorbuddy.color").colors
--     local Group = require("colorbuddy.group").Group
--     local g = require("colorbuddy.group").groups
--     local s = require("colorbuddy.style").styles
--
--     -- Group.new("GoTestSuccess", c.green, nil, s.bold)
--     -- Group.new("GoTestFail", c.red, nil, s.bold)
--     -- Group.new('Keyword', c.purple, nil, nil)
--     -- Group.new("LspReferenceText", nil, c.gray0:light(), s.bold)
--     -- Group.new("LspReferenceWrite", nil, c.gray0:light())
--     -- Group.new("TSKeyword", c.purple, nil, s.underline, c.blue)
--     -- Group.new("LuaFunctionCall", c.green, nil, s.underline + s.nocombine, g.TSKeyword.guisp)
--
--     Group.new("TSPunctBracket", c.orange:light():light())
--     Group.new("StatuslineError1", c.red:light():light(), g.Statusline)
--     Group.new("StatuslineError2", c.red:light(), g.Statusline)
--     Group.new("StatuslineError3", c.red, g.Statusline)
--     Group.new("StatuslineError3", c.red:dark(), g.Statusline)
--     Group.new("StatuslineError3", c.red:dark():dark(), g.Statusline)
--     Group.new("pythonTSType", c.red)
--     Group.new("goTSType", g.Type.fg:dark(), nil, g.Type)
--     Group.new("typescriptTSConstructor", g.pythonTSType)
--     Group.new("typescriptTSProperty", c.blue)
--     Group.new("WinSeparator", nil, nil)
--
--     Group.new("TSTitle", c.blue)
--
--     Group.new("CmpItemAbbr", g.Comment)
--     Group.new("CmpItemAbbrDeprecated", g.Error)
--     Group.new("CmpItemAbbrMatchFuzzy", g.CmpItemAbbr.fg:dark(), nil, s.italic)
--     Group.new("CmpItemKind", g.Special)
--     Group.new("CmpItemMenu", g.NonText)
--
--     Group.new("GitSignsAdd", c.green)
--     Group.new("GitSignsChange", c.yellow)
--     Group.new("GitSignsDelete", c.red)
--   end,
--   dependencies = { "tjdevries/colorbuddy.nvim", name = "colors_colorbuddy" },
--   lazy = lazy_third,
-- },
local function apply()
  require("colorbuddy").colorscheme("gruvbuddy")
end

local function setup(_)
  apply()
end

return {
  setup = setup,
}
