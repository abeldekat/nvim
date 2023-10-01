-- Minimal `init.lua` to reproduce an issue. Save as `repro.lua` and run with `nvim -u repro.lua`

local function bootstrap(root) -- sets std paths and installs lazy
  for _, name in ipairs({ "config", "data", "state", "cache" }) do
    vim.env[("XDG_%s_HOME"):format(name:upper())] = root .. "/" .. name
  end
  local lazypath = root .. "/plugins/lazy.nvim"
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", lazypath })
  end
  vim.opt.rtp:prepend(lazypath)
end

local function cond(keywords, result_when_matching) -- returns a default "cond" function
  local lowercase_keywords = keywords and vim.tbl_map(string.lower, keywords) or {}
  if result_when_matching then -- enabling: at least lazy.nvim, LazyVim and tokyonight
    lowercase_keywords = vim.list_extend({ "lazy", "toky" }, lowercase_keywords)
  end
  return function(plugin)
    local name = string.lower(plugin.name)
    for _, keyword in ipairs(lowercase_keywords) do
      if name:find(keyword, 1, true) then
        return result_when_matching
      end
    end
    return not result_when_matching
  end
end

local root = vim.fn.fnamemodify("./.repro", ":p")
bootstrap(root)

--> optional: do not load the options provided by LazyVim:
local options = true
-- local options = false
if not options then -- see lazyvim.config.init L18
  package.loaded["lazyvim.config.options"] = true
  vim.g.mapleader, vim.g.maplocalleader = " ", "\\"
end

--> optional: do not load the autocmds and keymaps provided by LazyVim:
local autocmds, keymaps = true, true
-- local autocmds, keymaps = false, false

--> optional: specify keywords to enable or disable plugins that match
local enable_on_match = true
local keywords = nil
-- LazyVim, lazy.nvim and tokyonight are always included:
-- local keywords = {}

-- install plugins:
local lazyvim = {
  "LazyVim/LazyVim",
  opts = { defaults = { autocmds = autocmds, keymaps = keymaps } },
  import = "lazyvim.plugins",
}
local plugins = {
  "folke/tokyonight.nvim",
  lazyvim,
  -- add any other plugins here
}
require("lazy").setup(plugins, {
  root = root .. "/plugins",
  defaults = {
    cond = keywords and cond(keywords, enable_on_match) or nil,
  },
})
-- add anything else here
