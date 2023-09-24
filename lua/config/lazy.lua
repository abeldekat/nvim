local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

-- approach: group each extra with its override
local full_spec = {
  { "LazyVim/LazyVim", import = "lazyvim.plugins" },
  --> util:
  -- { import = "lazyvim.plugins.extras.util.mini-hipatterns" },
  --> test:
  { import = "lazyvim.plugins.extras.test.core" },
  { import = "plugins.extras.test.core_override" },
  --> dap:
  -- { import = "lazyvim.plugins.extras.dap.core" },
  --> lang, json:
  { import = "lazyvim.plugins.extras.lang.json" },
  --> lang, python:
  { import = "lazyvim.plugins.extras.lang.python" },
  { import = "lazyvim.plugins.extras.lang.python-semshi" },
  { import = "plugins.extras.lang.python_override" },
  --> plugins:
  { import = "plugins" },
  { import = "plugins.extras.colors.group_one" },
  -- { import = "plugins.extras.colors.group_two" },
  -- { import = "plugins.extras.colors.group_three" },
  --> use neovim's default startscreen:
  { import = "plugins.extras.default_startscreen" },
}

-- uncomment to prevent loading the options LazyVim provides
-- package.loaded["lazyvim.config.options"] = true
-- vim.g.mapleader = " "
-- vim.g.maplocalleader = "\\"

-- stylua: ignore start
local conds = nil -- table of plugin keywords to enable
local conds_should_enable = false -- enable or disable the conds if not nil
-- stylua: ignore end

-- local dev_plugins = { "LazyVim" } -- jit.os:find("Windows") and {}
local dev_plugins = {}

require("lazy").setup({
  spec = full_spec,
  ---@diagnostic disable-next-line:assign-type-mismatch
  dev = { path = "~/projects/lazydev", patterns = dev_plugins }, -- fallback false
  defaults = {
    lazy = false,
    version = false, -- "*", -- try installing the latest stable version
    cond = conds and function(plugin)
      local name = string.lower(plugin.name)
      local keywords = conds_should_enable and vim.list_extend({ "laz", "tok" }, conds) or conds
      for _, keyword in ipairs(keywords) do
        if name:find(string.lower(keyword), 1, true) then
          return conds_should_enable and true or false
        end
      end
      return conds_should_enable and false or true
    end or nil,
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = { enabled = false }, -- automatically check for plugin updates
  change_detection = {
    enabled = false, -- check for config file changes and reload the ui
    notify = false, -- get a notification when changes are found
  },
  performance = {
    rtp = {
      -- "matchit", "matchparen",
      disabled_plugins = { "gzip", "netrwPlugin", "tarPlugin", "tohtml", "tutor", "zipPlugin" },
    },
  },
})
