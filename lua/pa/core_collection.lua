--[[
20220418:
24 plugins in start 14 plugins in opt
Total: 38 plugins
60% battery 240.014  000.009: -NVIM STARTED ---
]]

local result = {
  require "pa.packer_and_color",
  require "pa.prerequisites",
  require "pa.treesitter",
  require "pa.lsp",
  require "pa.basic",
  require "pa.cmp",
  require "pa.telescope",
}
return result
