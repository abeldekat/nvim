--[[
dap can be lazy loaded on module = "dap"

The intention: If both telescope and dap are installed,
the keymaps defined in this file will be created
Methods in this file do not assume that either telescope or dap is loaded

The telescope dap extension cannot be loaded in telescope setup,
as telescope is much broader than dap

Normally, without lazy loading, in the telescope setup,
the telescope dap extension would be preloaded:
require("telescope").load_extension "dap"

Methods in this file rely on telescopes lazy extension loading:
telescope.extensions.dap
This plugin is also overriding dap internal ui, so running any dap command,
which makes use of the internal ui, will result in a telescope prompt.
--]]

local optional_installs = require "ak.core.optional_installs"
local name = "nvim-dap"
if not optional_installs.is_installed(name, "dap") then
  return
end

local mapper = require "ak.telescope.mapper"

--KEY: Telescope Dap
-- see also dap setup
local key = "<leader>R"

local function list_breakpoints()
  local _ = require "dap"
  local telescope = require "telescope"
  local d = telescope.extensions.dap
  d.list_breakpoints()
end
mapper.map(key .. "b", list_breakpoints, "Dap List Breakpoints")

local function commands()
  local _ = require "dap"
  local telescope = require "telescope"
  local d = telescope.extensions.dap
  d.commands()
end
mapper.map(key .. "c", commands, "Dap Commands")

local function configurations()
  local _ = require "dap"
  local telescope = require "telescope"
  local d = telescope.extensions.dap
  d.configurations()
end
mapper.map(key .. "g", configurations, "Dap Configurations")

local function frames()
  local _ = require "dap"
  local telescope = require "telescope"
  local d = telescope.extensions.dap
  d.frames()
end
mapper.map(key .. "f", frames, "Dap Frames")

local function variables()
  local _ = require "dap"
  local telescope = require "telescope"
  local d = telescope.extensions.dap
  d.variables()
end
mapper.map(key .. "v", variables, "Dap Variables")
