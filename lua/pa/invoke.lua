-- Load packer and load the config containing all info about plugins
-- Now packer commands are available to achieve the end result: plugin/packer_compiled.lua

local M = {}
-- Note: Having all colors in opt does not increase startuptime!
local include_in_test = true

-- a list of strings of collections to require
local function build(collections, name)
  local result = {}
  for _, collection in ipairs(collections) do
    table.insert(result, collection)
  end
  if include_in_test then
    table.insert(result, (require "pa.in_test_collection"))
  end

  vim.api.nvim_echo({
    {
      string.format("Preparing packer: load [%s]. Test collection[%s]", name, include_in_test),
    },
  }, false, {})
  return result
end

function M.load_core_collection()
  local tobuild = build({ require "pa.core_collection" }, "core")
  require("pa.collection_loader").setup(tobuild)
end

function M.load_core_collection_and_colors()
  local tobuild = build({ require "pa.core_collection", require "pa.color_collection" }, "core and colors")
  require("pa.collection_loader").setup(tobuild)
end

function M.load_nth_collection()
  local tobuild = build(
    { require "pa.packer_and_color", require "pa.prerequisites", require "pa.nth_collection" },
    "packer, prerequisites and nice to have"
  )
  require("pa.collection_loader").setup(tobuild)
end

function M.load_nth_collection_and_colors()
  local tobuild = build({
    require "pa.packer_and_color",
    require "pa.prerequisites",
    require "pa.nth_collection",
    require "pa.color_collection",
  }, "packer, prerequisites, nice to have and colors")
  require("pa.collection_loader").setup(tobuild)
end

function M.load_color_collection()
  local tobuild = build({
    require "pa.packer_and_color",
    require "pa.prerequisites",
    require "pa.color_collection",
  }, "packer, prerequisites, and colors")
  require("pa.collection_loader").setup(tobuild)
end

function M.load_all_collection()
  local tobuild = build(
    { require "pa.core_collection", require "pa.nth_collection", require "pa.color_collection" },
    "all"
  )
  require("pa.collection_loader").setup(tobuild)
end

return M
