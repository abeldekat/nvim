--[[
A note: use git reflog in pack/packer
--]]
local fn = vim.fn
local cmd = vim.cmd
local in_headless = #vim.api.nvim_list_uis() == 0
local log_level = in_headless and "debug" or "warn"
local optional_installs = require "ak.core.optional_installs"
local package_name = "packer.nvim"

local packer = nil

local function setup(collections)
  if not packer then
    if not optional_installs.is_installed(package_name, "packer") then
      fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        optional_installs.get_path(package_name),
      }
    end

    cmd "packadd packer.nvim"
    local packer_available, result = pcall(require, "packer")
    if not packer_available then
      return
    end

    packer = result
  end

  packer.init {
    log = { level = log_level },
    git = {
      clone_timeout = 300,
      -- subcommands = {
      --   -- this is more efficient than what Packer is using
      --   fetch = "fetch --no-tags --no-recurse-submodules --update-shallow --progress",
      -- },
    },
    max_jobs = 50,
    display = {
      open_fn = function()
        return require("packer.util").float { border = "rounded" }
      end,
    },
  }
  packer.reset()

  local use = packer.use

  for _, collection in ipairs(collections) do
    if not vim.tbl_isempty(collection) then
      for _, plugin in ipairs(collection) do
        use(plugin)
      end
    end
  end
end

-- Layzload and initialize packer. Commands will be created
return {
  setup = setup,
}
