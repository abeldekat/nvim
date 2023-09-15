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
  { import = "plugins.extras.test.core" },
  --> dap:
  -- { import = "lazyvim.plugins.extras.dap.core" },
  --> lang, json:
  { import = "lazyvim.plugins.extras.lang.json" },
  --> lang, python:
  { import = "lazyvim.plugins.extras.lang.python" },
  { import = "lazyvim.plugins.extras.lang.python-semshi" },
  { import = "plugins.extras.lang.python" },

  { import = "plugins" },
  { import = "plugins.extras.colors.group_one" },
  -- { import = "plugins.extras.colors.group_two" },
  -- { import = "plugins.extras.colors.group_three" },
}

-- local dev_plugins = { "LazyVim" } -- jit.os:find("Windows") and {}
local dev_plugins = {}
require("lazy").setup({
  spec = full_spec,
  ---@diagnostic disable-next-line:assign-type-mismatch
  dev = { path = "~/projects/lazydev", patterns = dev_plugins }, -- fallback false
  defaults = {
    lazy = false,
    version = false, -- always use the latest git commit, recommended for now
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = { enabled = false }, -- automatically check for plugin updates
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
