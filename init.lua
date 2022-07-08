--[[

Initial install:
  press <leader>ma (see keybindings.lua)
  PackerSync
  restart

Loading order:
init.lua
plugin/*.lua:
  all code not related to plugins(options, etc)
  packer_compiled, which is only used for lazy loading
after/plugin/*.lua
  colorscheme ( starts with a "c" and thus is first to load )
  all files setup one ore more plugins

It is also possible to load without lazy loading using the
following script:
./scratch/reset_nvim.sh -N
Most importantly:
./plugin/packer_compiled.lua will be deleted
./after/plugin/zz_self_compiled_from_lazy.lua will be generated

The most valid question when introducing lazy loading for a plugin:
  Can it be on demand and is the time gain worth increased complexity?
    Example yes, telescope. Is used frequently but only after neovim is active
    Example no, lualine. If present, always shows.

--]]

local function first_settings()
  vim.g.do_filetype_lua = 1
  vim.g.did_load_filetypes = 0

  vim.g.mapleader = [[ ]]

  -- defaults to \
  -- g.maplocalleader = [[,]]
end

local function add_speed()
  -- Attempt to run impatient
  pcall(function()
    require "impatient"

    -- Impatient present:
    -- Assume presence of core collection plugins:
    require "ak.disable_builtin"
  end)
end

local function first_load()
  require "ak.diagnostics"
  require "ak.lsp"
  require "ak.null_ls"

  -- lazy loading enabled, only keys:
  require "ak.telescope"
  -- lazy loading enabled, only keys:
  require "ak.dap"
end

first_settings()
add_speed()
first_load()
